import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/views/activity/widget/BlocActivity.dart';

class BlocActivityDate extends StatelessWidget {
  final String date;
  final List<Activity> activityList;
  const BlocActivityDate(
      {Key? key, required this.date, required this.activityList})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0, left: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                getPrettierStringDate(date),
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Row(
            children: [
              for (var activity in activityList)
                BlocActivity(activity: activity),
            ],
          ),
        ],
      ),
    );
  }

  String getPrettierStringDate(String date) {
    DateTime datetime = DateFormat("yyyy-MM-dd").parse(date);

    return DateFormat('EEEE dd MMMM', 'FR').format(datetime);
  }
}
