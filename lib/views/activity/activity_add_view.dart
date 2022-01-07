import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yorgo/views/activity/activity_create_alone.dart';
import 'package:yorgo/views/activity/activity_create_group.dart';
import 'package:yorgo/widgets/buttons/GlobalButton.dart';

class ActivityAddView extends StatelessWidget {
  const ActivityAddView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(207, 227, 239, 1),
                    Color.fromRGBO(195, 213, 229, 1),
                    Color.fromRGBO(173, 200, 221, 1),
                    Color.fromRGBO(164, 192, 216, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.4, 0.6, 0.7, 1]),
            ),
            alignment: Alignment.topCenter),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              AutoSizeText(
                "Avec qui voulez-vous faire l'activité ?",
                maxLines: 1,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Container(
                height: 30,
              ),
              GlobalButton1(
                text: "SEUL",
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ActivityCreateAloneView.routeName);
                },
              ),
              Container(
                height: 20,
              ),
              GlobalButton1(
                text: "EN GROUPE",
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ActivityCreateGroupView.routeName);
                },
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
