import 'package:flutter/material.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/views/activity/widget/BlocActivityDate.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ActivityCategoryView extends StatelessWidget {
  static String routeName = '/activity_category_view';
  final int idCategory;
  final String nameCategory;
  final Map<String, List<Activity>> initMapActivityByDate;
  const ActivityCategoryView({
    Key? key,
    required this.idCategory,
    required this.nameCategory,
    required this.initMapActivityByDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        text: nameCategory,
        fontSize: 30,
      ),
      body: ListView(
        children: [
          for (var key in initMapActivityByDate.keys)
            BlocActivityDate2(
              date: key,
              activityList: initMapActivityByDate[key]!,
            ),
        ],
      ),
    );
  }
}
