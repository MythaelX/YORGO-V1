import 'package:flutter/material.dart';
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

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  int currentIndex = 2;

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
      body: Container(child: screens[currentIndex]),
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
