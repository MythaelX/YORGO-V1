import 'package:flutter/material.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/views/profile/widget/backgroundProfile.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';
import 'package:yorgo/views/profile/widget/sportHeaderProfile.dart';
import 'package:yorgo/widgets/colorTexts/textBlue.dart';

class headerProfile extends StatelessWidget {
  final User? user;

  const headerProfile({
    Key? key,
    required this.user,
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
                  text: ' ${user!.username.toUpperCase()}',
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ),
              Container(
                height: 15,
              ),
              Row(children: [
                Expanded(
                  child: Container(
                    child: Align(
                        child: TextBlue(
                      text: "X\n Activités",
                      textFontsize: 20,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Align(
                        child: TextBlue(
                      text: "X\n Amis",
                      textFontsize: 20,
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Align(
                        child: TextBlue(
                      text: "X\n Abonnés",
                      textFontsize: 20,
                      textAlign: TextAlign.center,
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
              userSports: user!.sports,
            ),
          ),
          Positioned(
            top: 10,
            left: 30,
            child: ImageProfile(height: 160, image: user!.profile_image),
          ),
        ],
      ),
    );
  }
}
