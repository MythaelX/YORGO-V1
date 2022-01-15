import 'package:flutter/material.dart';
import 'package:yorgo/views/activity/activity_add_view.dart';
import 'package:yorgo/views/activity/activity_map_view.dart';
import 'package:yorgo/views/activity/activity_global_view.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class ActivityHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        tabBarMenu2Icon(listContentTab: [
          ActivityGlobalView(),
          ActivityMapView(),
          ActivityAddView(),
        ], listTab: [
          Icon(
            Icons.search,
            size: 30,
          ),
          Icon(
            Icons.map_outlined,
            size: 30,
          ),
          Icon(
            Icons.add_circle_outline,
            size: 30,
          ),
          // "Accueil",
          // "Cartes",
          // "Nouveau"
        ], length: 3),
        // //Todo : add filter here;
      ],
    );
  }
}
