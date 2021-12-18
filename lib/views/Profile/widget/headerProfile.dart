import 'package:flutter/material.dart';
import 'package:yorgo/models/data/user_model.dart';
import 'package:yorgo/views/profile/widget/backgroundProfile.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';
import 'package:yorgo/views/profile/widget/sportHeaderProfile.dart';
import 'package:yorgo/widgets/colorTexts/textBlue.dart';

class headerProfile extends StatelessWidget {
  final int? numberOfFriends;
  final User user;
  final void Function()? friendFunction;
  final void Function()? activityFunction;
  final void Function()? followFunction;
  const headerProfile(
    this.user, {
    Key? key,
    this.numberOfFriends,
    this.friendFunction,
    this.activityFunction,
    this.followFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              BackgroundProfile(
                height: 110,
                image: null,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: (width / 2.2), top: 15, right: 10),
                child: TextBlue(
                  text: ' ${user.username.toUpperCase()}',
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ),
              Container(
                height: 15,
              ),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextButton(
                      onPressed: activityFunction,
                      child: Align(
                        child: TextBlue(
                          text: "X\n Activités",
                          textFontsize: 20,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextButton(
                      onPressed: friendFunction,
                      child: Align(
                          child: TextBlue(
                        text: numberOfFriends.toString() + "\n Amis",
                        textFontsize: 20,
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextButton(
                        onPressed: followFunction,
                        child: Align(
                          child: TextBlue(
                            text: "X\n Abonnés",
                            textFontsize: 20,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ),
              ]),
              Container(
                height: 10,
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: SportHeaderProfile(
              width: width,
              height: 50,
              userSports: user.sports,
            ),
          ),
          Positioned(
            top: 10,
            left: 30,
            child: ImageProfile(size: 160, image: user.profile_image),
          ),
        ],
      ),
    );
  }
}
