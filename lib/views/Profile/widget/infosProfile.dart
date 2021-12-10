import 'package:flutter/material.dart';
import 'package:yorgo/models/user_model.dart';

class InfosProfile extends StatelessWidget {
  final User user;

  const InfosProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textBlockInfos(
              text: user.getGenderString(),
              textStyle: textStyle,
              iconData: Icons.transgender),
          textBlockInfos(
              text: user.getAgeString(),
              textStyle: textStyle,
              iconData: Icons.date_range_outlined),
          textBlockInfos(
              text: user.getAdressString(),
              textStyle: textStyle,
              iconData: Icons.maps_home_work_rounded,
              border: false),
        ],
      ),
    );
  }
}

class textBlockInfos extends StatelessWidget {
  const textBlockInfos({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.iconData,
    this.border = true,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final bool border;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: (border)
                ? Border(
                    bottom: BorderSide(
                        width: 2, color: Color.fromRGBO(112, 112, 112, 0.14)))
                : null),
        child: RichText(
          maxLines: 1,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(iconData, size: 30),
              ),
              TextSpan(
                text: "   " + text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
