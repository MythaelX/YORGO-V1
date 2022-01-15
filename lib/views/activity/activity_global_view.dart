import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/activity_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/activity/activity_search_view.dart';
import 'package:yorgo/views/activity/widget/CategoryActivity.dart';
import 'package:yorgo/views/activity/widget/SearchBarActivity.dart';

class ActivityGlobalView extends StatelessWidget {
  const ActivityGlobalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final globalCategoryActivity =
        Provider.of<ActivityProvider>(context).globalCategoryActivity;
    return Container(
      child: globalCategoryActivity != null
          ? ListView(
              children: [
                SearchBarActivity(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Navigator.push(
                      context,
                      FadeRoute(page: ActivitySearchView()),
                    );
                  },
                ),
                for (var categoryActivity in globalCategoryActivity)
                  CategoryActivity(activityMap: categoryActivity),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
