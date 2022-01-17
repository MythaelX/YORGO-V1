import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/models/data/utils_model.dart';
import 'package:yorgo/providers/sport_provider.dart';
import 'package:yorgo/views/activity/widget/ButtonActivityOrga.dart';
import 'package:yorgo/widgets/GetImageProfile.dart';
import 'package:yorgo/widgets/buttons/GlobalButton.dart';
import 'package:yorgo/widgets/colorTexts/textBlue.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ActivityDetailsView extends StatelessWidget {
  static String routeName = '/activity_details';
  final Activity? activity;
  final int idActivity;

  const ActivityDetailsView({
    Key? key,
    required this.idActivity,
    this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Sport sport =
        Provider.of<SportProvider>(context).getSportByID(activity!.sport);
    final Map imageSports = Provider.of<SportProvider>(context).imageSports;
    Divider divider = const Divider(
      color: Colors.grey,
      indent: 10,
      endIndent: 10,
      height: 15,
      thickness: 0.5,
    );
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
      body: activity != null
          ? ListView(
              children: [
                HeaderActivityDetails(
                    imageSports: imageSports, activity: activity),
                ButtonActivityOrga(activity: activity),
                divider,
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
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
                    activity!.description!,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
                divider,
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextBlue(
                    text: "Infos pratiques",
                    textAlign: TextAlign.start,
                    textFontsize: 22,
                  ),
                ),
                GetInformationDetail(
                  text: activity!.getTimeStartEnd(),
                  iconData: Icons.watch_later_outlined,
                ),
                divider2,
                GetInformationDetail(
                  text: activity!.getDateStart(),
                  iconData: Icons.date_range_outlined,
                ),
                divider2,
                GetInformationDetail(
                  text: activity!.address_text!,
                  iconData: Icons.map_outlined,
                ),
                divider2,
                GetInformationDetail(
                  text: activity!.getLevelText(),
                  iconData: Icons.offline_bolt_rounded,
                ),
                divider,
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextBlue(
                    text: getTextParticpant(activity!.numberOfParticipant!,
                        activity!.numberOfLimitParticipant!),
                    textAlign: TextAlign.start,
                    textFontsize: 22,
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(),
    );
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

class HeaderActivityDetails extends StatelessWidget {
  const HeaderActivityDetails({
    Key? key,
    required this.imageSports,
    required this.activity,
  }) : super(key: key);

  final Map imageSports;
  final Activity? activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(imageSports[activity!.sport]),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.8),
                child: Text(
                  activity!.title,
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
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    print("oui");
                  },
                  icon: Icon(Icons.group_add),
                ),
              ),
            ),
          ),
          Positioned(
            top: 155,
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
