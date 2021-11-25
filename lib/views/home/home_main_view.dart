import 'package:flutter/material.dart';
import 'package:yorgo/views/profile/profile_view.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/navigation_bottom-bar_widget.dart';
import 'package:yorgo/widgets/navigation_drawer_widget.dart';

class HomeMainView extends StatefulWidget {
  static String routeName = '/homemain';

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  int currentIndex = 2;

  final screens = [
    Center(child: Text('Activité')),
    Center(child: Text('Message')),
    Center(child: Text('Flux')),
    Center(child: Text('Notif')),
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
      appBar: HeaderAppBar(texte: "Yorgo"),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: NavigationBottomBarWidget(
        selectedIndex: currentIndex,
        onClicked: onClicked,
      ),
      body: screens[currentIndex],
    );
  }
}
