import 'package:flutter/material.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/widgets/GetImageProfile.dart';

class ButtonActivityOrga extends StatelessWidget {
  const ButtonActivityOrga({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity? activity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("organisateurs");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Container(
                width: 10,
              ),
              ClipOval(child: GetImageProfile(imageUrl: activity!.userImage)),
              Container(
                width: 10,
              ),
              Text(
                activity!.username,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
