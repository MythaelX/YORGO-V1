import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yorgo/ads/ad_helper.dart';
import 'package:yorgo/views/activity/activity_home_view.dart';
import 'package:yorgo/views/flux/flux_view.dart';
import 'package:yorgo/views/message/message_home_view.dart';
import 'package:yorgo/views/message/message_new.dart';
import 'package:yorgo/views/notification/notification_view.dart';
import 'package:yorgo/views/profile/profile_view.dart';
import 'package:yorgo/views/setting/settingMenuView.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/menus/navigation_bottom-bar_widget.dart';
import 'package:yorgo/widgets/menus/navigation_drawer_widget.dart';

class HomeMainView extends StatefulWidget {
  static String routeName = '/home_main';

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  int currentIndex = 2;

  // ads
  static final _kAdIndex = 4;
  late BannerAd _ad;
  bool _isAdLoaded = false;
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  final screens = [
    ActivityHomeView(),
    MessageHomeView(),
    FluxView(),
    NotificationView(),
    ProfileView(),
  ];

  void onClicked(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // Banner ADS
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderAppBar(
        text: "Yorgo",
        config: (currentIndex == 4 || currentIndex == 1) ? true : false,
        configRouteName: getConfigRouteName(currentIndex),
        configIcon: getConfigIcon(currentIndex),
        elevation: (currentIndex == 3 || currentIndex == 4) ? true : false,
      ),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: NavigationBottomBarWidget(
        selectedIndex: currentIndex,
        onClicked: onClicked,
      ),
      body: Column(
        children: [
          Expanded(child: Container(child: screens[currentIndex])),
          Container(
            color: Colors.grey,
            child:
                _isAdLoaded ? AdWidget(ad: _ad) : CircularProgressIndicator(),
            height: 60.0,
            alignment: Alignment.center,
          ),
        ],
      ),
      //,
    );
  }

  getConfigRouteName(int currentIndex) {
    switch (currentIndex) {
      case 4:
        return SettingMenuView.routeName;
      case 1:
        return MessageNewView.routeName;
      default:
        return null;
    }
  }

  getConfigIcon(int currentIndex) {
    switch (currentIndex) {
      case 4:
        return Icon(
          Icons.settings,
          color: Colors.white,
          size: 30,
        );
      case 1:
        return Icon(
          Icons.messenger_outline,
          color: Colors.white,
          size: 30,
        );
      default:
        return null;
    }
  }
}
