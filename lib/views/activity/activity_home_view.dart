import 'package:flutter/material.dart';
import 'package:yorgo/views/activity/activity_add_view.dart';
import 'package:yorgo/views/activity/activity_map_view.dart';
import 'package:yorgo/views/activity/activity_search_view.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class ActivityHomeView extends StatelessWidget {
  static String routeName = '/activity';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            tabBarMenu2(listContentTab: [
              ActivitySearchView(),
              ActivityMapView(),
              ActivityAddView(),
            ], listTab: [
              "Recherche",
              "Cartes",
              "Nouveau"
            ], length: 3),
            //Todo : add filter here;
          ],
        ),
      ),
    );
  }
}
