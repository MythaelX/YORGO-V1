import 'package:flutter/material.dart';
import 'package:yorgo/views/home/home_main_view.dart';
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
      body: Stack(
        children: [
          Container(
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
                    Text(
                      "Moteur de recherche",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
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
                    Text(
                      "Get all sport with category",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
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
                    Container(height: 2000),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.all(20),
                child: GradientElevatedButton2(
                  function: () => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeMainView()),
                      (route) => false,
                    )
                  },
                  text: "Continuer",
                  page: 2,
                  numberPage: 2,
                  colors: [Color(0xff65C5F8), Color(0xff2D93CC)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
