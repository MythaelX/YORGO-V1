import 'package:flutter/material.dart';
import 'package:yorgo/views/friend/friend_ask_view.dart';
import 'package:yorgo/views/friend/friend_map_view.dart';
import 'package:yorgo/views/friend/friend_search_view.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class FriendHomeView extends StatelessWidget {
  static String routeName = '/friend_home';
  final int? tabIndex;
  const FriendHomeView({
    Key? key,
    this.tabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Mes Amis",
        elevation: false,
      ),
      body: Container(
        color: Colors.white,
        child: tabBarMenu2Icon(
          listContentTab: [
            FriendSearchView(),
            FriendMapView(),
            FriendAskView(),
          ],
          listTab: [
            Icon(
              Icons.person_search_sharp,
              size: 30,
            ),
            Icon(
              Icons.map_outlined,
              size: 30,
            ),
            Icon(
              Icons.person_add,
              size: 30,
            ),
          ],
          length: 3,
          tabIndex: (tabIndex != null) ? tabIndex! : 0,
        ),
      ),
    );
  }
}
