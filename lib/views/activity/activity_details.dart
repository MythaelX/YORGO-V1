import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/models/data/user_model.dart';
import 'package:yorgo/providers/activity_provider.dart';
import 'package:yorgo/providers/sport_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/activity/widget/ButtonActivityOrga.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';
import 'package:yorgo/widgets/buttons/GlobalButton.dart';
import 'package:yorgo/widgets/colorTexts/textBlue.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ActivityDetailsView extends StatelessWidget {
  static String routeName = '/activity_details';
  final Activity activity;
  final int idActivity;

  const ActivityDetailsView({
    Key? key,
    required this.idActivity,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Sport sport =
        Provider.of<SportProvider>(context).getSportByID(activity.sport);
    final Map imageSports = Provider.of<SportProvider>(context).imageSports;
    final User? user = Provider.of<UserProvider>(context).user;
    // -1 = not in activity / 0 = in activity / 1 = my activity
    int viewId = getViewId(user!, activity);
    Divider divider2 = const Divider(
      color: Colors.grey,
      indent: 20,
      endIndent: 20,
      height: 15,
      thickness: 0.5,
    );
    return Scaffold(
        appBar: HeaderAppBar(
          text: sport.name,
          fontSize: 30,
        ),
        body: ListView(
          children: [
            HeaderActivityDetails(
                imageSports: imageSports, activity: activity, viewId: viewId),
            ButtonActivityOrga(activity: activity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: TextBlue(
                text: "Description",
                textAlign: TextAlign.start,
                textFontsize: 22,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Text(
                activity.description!,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: TextBlue(
                text: "Infos pratiques",
                textAlign: TextAlign.start,
                textFontsize: 22,
              ),
            ),
            GetInformationDetail(
              text: activity.getTimeStartEnd(),
              iconData: Icons.watch_later_outlined,
            ),
            divider2,
            GetInformationDetail(
              text: activity.getDateStart(),
              iconData: Icons.date_range_outlined,
            ),
            divider2,
            GetInformationDetail(
              text: activity.address_text.toString(),
              iconData: Icons.map_outlined,
            ),
            divider2,
            GetInformationDetail(
              text: activity.getLevelText(),
              iconData: Icons.offline_bolt_rounded,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: TextBlue(
                text: getTextParticpant(activity.numberOfParticipant!,
                    activity.numberOfLimitParticipant!),
                textAlign: TextAlign.start,
                textFontsize: 22,
              ),
            ),
            Container(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 55,
                      child: Column(
                        children: [
                          Container(
                            width: 55,
                            child: ImageProfile(
                                image: user.profile_image, size: 55),
                          ),
                          AutoSizeText(user.username)
                        ],
                      ),
                    ),
                  ),
                  for (Account userActivity in activity.users!)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 55,
                        child: Column(
                          children: [
                            Container(
                              width: 55,
                              child: ImageProfile(
                                  image: userActivity.profile_image, size: 55),
                            ),
                            AutoSizeText(userActivity.username!)
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ));
  }

  getTextParticpant(int numberOfParticipant, int numberOfLimitParticipant) {
    if (numberOfLimitParticipant != -1 && numberOfLimitParticipant != 0) {
      return "Participants: " +
          numberOfParticipant.toString() +
          " / " +
          numberOfLimitParticipant.toString();
    }
    return "Participants: " + numberOfParticipant.toString();
  }

  int getViewId(User user, Activity activity) {
    if (user.id == activity.user_id) {
      return 1;
    }
    if (activity.users != null) {
      for (Account account in activity.users!) {
        if (account.id == user.id) {
          return 0;
        }
      }
    }
    return -1;
  }
}

class GetInformationDetail extends StatelessWidget {
  final String text;
  final IconData iconData;
  const GetInformationDetail({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
        ),
        Icon(
          iconData,
          size: 28,
        ),
        Container(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class HeaderActivityDetails extends StatefulWidget {
  const HeaderActivityDetails({
    Key? key,
    required this.imageSports,
    required this.activity,
    required this.viewId,
  }) : super(key: key);

  final Map imageSports;
  final Activity activity;
  final int viewId;

  @override
  State<HeaderActivityDetails> createState() => _HeaderActivityDetailsState();
}

class _HeaderActivityDetailsState extends State<HeaderActivityDetails> {
  int? viewId;
  @override
  Widget build(BuildContext context) {
    if (viewId == null) {
      viewId = widget.viewId;
    }
    return Container(
      height: (viewId == -1) ? 190 : 240,
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(widget.imageSports[widget.activity.sport]),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.8),
                child: Text(
                  widget.activity.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: 20,
            child: Container(
              height: 60,
              width: 60,
              child: (viewId == -1)
                  ? CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.white,
                        iconSize: 35,
                        onPressed: () async {
                          setState(() {
                            viewId = 0;
                          });
                          var error = await Provider.of<ActivityProvider>(
                                  context,
                                  listen: false)
                              .joinUserActivityGroupByID(widget.activity.id);
                          if (error != null) {
                            setState(() {
                              viewId = -1;
                            });
                          }
                        },
                        icon: Icon(Icons.group_add),
                      ),
                    )
                  : null,
            ),
          ),
          Positioned(
            top: 150,
            width: MediaQuery.of(context).size.width,
            child: Container(
                height: 60,
                padding: EdgeInsets.all(5),
                child: (viewId == 1)
                    ? GlobalButton1(
                        text: "Supprimer",
                        color: Colors.red,
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          Navigator.pop(context);
                          Provider.of<ActivityProvider>(context, listen: false)
                              .removeActivityGroupByID(widget.activity.id);
                        },
                      )
                    : (viewId == 0)
                        ? GlobalButton1(
                            text: "Quitter",
                            color: Colors.red,
                            padding: EdgeInsets.all(0),
                            onPressed: () async {
                              setState(() {
                                viewId = -1;
                              });
                              Navigator.pop(context);
                              Provider.of<ActivityProvider>(context,
                                      listen: false)
                                  .removeUserActivityGroupByID(
                                      widget.activity.id);
                            },
                          )
                        : null),
          ),
          Positioned(
            top: (viewId == -1) ? 155 : 210,
            left: 5,
            child: TextBlue(
              text: "Organisateurs",
              textFontsize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
