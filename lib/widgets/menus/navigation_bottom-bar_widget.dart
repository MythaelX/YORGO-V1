import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:badges/badges.dart';

// ignore: must_be_immutable
class NavigationBottomBarWidget extends StatefulWidget {
  final selectedIndex;
  ValueChanged<int>? onClicked;
  NavigationBottomBarWidget({this.selectedIndex, this.onClicked});

  @override
  State<NavigationBottomBarWidget> createState() =>
      _NavigationBottomBarWidgetState();
}

class _NavigationBottomBarWidgetState extends State<NavigationBottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    final numberofMessageNotRead =
        Provider.of<NotificationProvider>(context).countNotReadMessage;
    final numberofNotificationNotRead =
        Provider.of<NotificationProvider>(context).countNotReadNotification;
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
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Activités',
        ),
        BottomNavigationBarItem(
          icon: Badge(
              showBadge:
                  (numberofMessageNotRead != null && numberofMessageNotRead > 0)
                      ? true
                      : false,
              badgeContent: (numberofMessageNotRead != null)
                  ? Center(
                      child: Text(
                        numberofMessageNotRead.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
              child: Icon(Icons.message)),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Flux',
        ),
        BottomNavigationBarItem(
          icon: Badge(
              showBadge: (numberofNotificationNotRead != null &&
                      numberofNotificationNotRead > 0)
                  ? true
                  : false,
              badgeContent: (numberofNotificationNotRead != null)
                  ? Center(
                      child: Text(
                        numberofNotificationNotRead.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
              child: Icon(
                Icons.notifications_outlined,
              )),
          label: 'Notif',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Color.fromRGBO(73, 165, 216, 1),
      onTap: widget.onClicked,
    );
  }
}
