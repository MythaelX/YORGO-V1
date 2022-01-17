import 'package:flutter/material.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/activity/activity_category_view.dart';
import 'package:yorgo/views/activity/widget/BlocActivityDate.dart';

class CategoryActivity extends StatelessWidget {
  final Map activityMap;

  const CategoryActivity({
    Key? key,
    required this.activityMap,
  }) : super(key: key);

  Map<String, List<Activity>> getActivityByDate(List activityList) {
    Map<String, List<Activity>> activityByDate = {};
    for (var i = 0; i < activityList.length; i++) {
      Activity activity = Activity.fromJson(activityList.elementAt(i));
      String key = activity.getDateStartYYYYMMJJ();
      if (!activityByDate.containsKey(key)) {
        activityByDate[key] = [];
      }
      activityByDate[key]!.add(activity);
    }
    return activityByDate;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    Map<String, List<Activity>> activityByDate =
        getActivityByDate(activityMap["activity"]);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5,
        child: Container(
          color: Colors.white,
          height: 280,
          child: Column(
            children: [
              Material(
                elevation: 2,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ActivityCategoryView.routeName,
                      arguments: ActivityCategoryArguments(
                          int.parse(activityMap['id']),
                          activityMap['name'],
                          activityByDate),
                    );
                  },
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: activityMap["name"]),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child:
                                  Icon(Icons.arrow_forward_ios_sharp, size: 28),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var key in activityByDate.keys)
                        Row(
                          children: [
                            BlocActivityDate(
                              date: key,
                              activityList: activityByDate[key]!,
                            ),
                            Container(
                              height: 130,
                              width: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
