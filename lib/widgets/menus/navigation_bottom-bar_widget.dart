import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationBottomBarWidget extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int>? onClicked;
  NavigationBottomBarWidget({this.selectedIndex, this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black54,
      unselectedFontSize: 15,
      selectedFontSize: 17,
      iconSize: 25,
      selectedIconTheme: IconThemeData(size: 30),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Activités',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Flux',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: 'Notif',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color.fromRGBO(73, 165, 216, 1),
      onTap: onClicked,
    );
  }
}
