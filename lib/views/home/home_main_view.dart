import 'dart:ui';

import 'package:flutter/material.dart';
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
    Center(child: Text('home')),
    Center(child: Text('home2')),
    Center(child: Text('home3')),
    Center(child: Text('home4')),
    Center(child: Text('home5')),
  ];

  void onClicked(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("YORGO"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: NavigationBottomBarWidget(
        selectedIndex: currentIndex,
        onClicked: onClicked,
      ),
      body: screens[currentIndex],
    );
  }
}
