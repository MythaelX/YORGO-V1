import 'package:flutter/material.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ProfileSportCreateView extends StatelessWidget {
  static String routeName = '/profil_sport_create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        texte: "Mon Profil",
        backButton: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(207, 227, 239, 1),
                Color.fromRGBO(195, 213, 229, 1),
                Color.fromRGBO(173, 200, 221, 1),
                Color.fromRGBO(164, 192, 216, 1),
                Color.fromRGBO(126, 166, 198, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.2, 0.3, 0.4, 1]),
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Indiquez les sports que vous pratiquez",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: Offset(3, 1),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                ),
                Container(height: 20),
                GradientElevatedButton2(
                  function: () => {},
                  text: "Continuer",
                  page: 1,
                  numberPage: 2,
                  colors: [Color(0xff65C5F8), Color(0xff2D93CC)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
