import 'package:flutter/material.dart';
import 'package:yorgo/views/message/message_activity_view.dart';
import 'package:yorgo/views/message/message_groups_view.dart';
import 'package:yorgo/views/message/message_sportsmen_view.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class MessageHomeView extends StatelessWidget {
  static String routeName = '/home_message';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            tabBarMenu2Icon(listContentTab: [
              MessageSportsmenView(),
              MessageGroupsView(),
              MessageActivityView(),
            ], listTab: [
              Icon(
                Icons.person,
                size: 30,
              ),
              Icon(
                Icons.people_alt,
                size: 30,
              ),
              Icon(
                Icons.directions_run,
                size: 30,
              ),
            ], length: 3),
            //Todo : add filter here;
          ],
        ),
      ),
    );
  }
}
