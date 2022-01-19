import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/activity/widget/BlocActivity.dart';
import 'package:yorgo/views/activity/widget/BlocActivityDate.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class MyActivityView extends StatelessWidget {
  static String routeName = '/my_activity';

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Activity>>? activityFuture =
        Provider.of<UserProvider>(context).activityFuture;
    final Map<String, List<Activity>>? activityPast =
        Provider.of<UserProvider>(context).activityPast;
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Mes Activités",
        elevation: false,
      ),
      body: (activityPast != null && activityFuture != null)
          ? tabBarMenu2Icon(listContentTab: [
              ListView(
                children: [
                  for (var key in activityPast.keys)
                    BlocActivityDate2(
                      date: key,
                      activityList: activityPast[key]!,
                    ),
                ],
              ),
              ListView(
                children: [
                  for (var key in activityFuture.keys)
                    BlocActivityDate2(
                      date: key,
                      activityList: activityFuture[key]!,
                    ),
                ],
              ),
            ], listTab: [
              Transform.rotate(
                  angle: pi,
                  child: Icon(
                    Icons.double_arrow_outlined,
                    size: 30,
                  )),
              Icon(
                Icons.double_arrow_outlined,
                size: 30,
              ),
              // "Accueil",
              // "Cartes",
              // "Nouveau"
            ], length: 2)
          : Center(child: CircularProgressIndicator()),
      // //Todo : add filter here;
    );
  }
}
