import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/activity_model.dart';
import 'package:yorgo/providers/sport_provider.dart';

class BlocActivity extends StatelessWidget {
  final Activity activity;
  const BlocActivity({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final Map imageSports = Provider.of<SportProvider>(context).imageSports;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Material(
        elevation: 3,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          onTap: () {
            print("ouiii");
          },
          child: Container(
              height: 190,
              width: 180,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                          height: 160,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Ink.image(
                              image: AssetImage(imageSports[activity.sport]),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Transform.rotate(
                            angle: 45 * pi / 180,
                            child: Icon(Icons.navigation_rounded),
                          ),
                          AutoSizeText(
                            activity.address_text!,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Text(
                            activity.getTimeStartEnd(),
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.8),
                                    offset: Offset(3, 2),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: 180,
                        height: 50,
                        color: Colors.black.withOpacity(0.4),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              activity.title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          Text(
                            activity.numberOfParticipant.toString() +
                                "/" +
                                getNumberOfParticipantLimit(
                                    activity.numberOfLimitParticipant),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  String getNumberOfParticipantLimit(int? numberOfParticipantLimit) {
    if (numberOfParticipantLimit != -1 && numberOfParticipantLimit != 0) {
      return numberOfParticipantLimit.toString();
    } else {
      return "∞";
    }
  }
}
