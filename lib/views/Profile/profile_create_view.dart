import 'package:flutter/material.dart';
import 'package:yorgo/views/profile/profile_sport_create.dart';
import 'package:yorgo/widgets/FormWidgets/inputDate.dart';
import 'package:yorgo/widgets/FormWidgets/inputImage.dart';
import 'package:yorgo/widgets/FormWidgets/inputLocalization.dart';
import 'package:yorgo/widgets/FormWidgets/inputNum.dart';
import 'package:yorgo/widgets/FormWidgets/inputText.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';
import 'package:yorgo/widgets/FormWidgets/InputRadioButton.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ProfileCreateView extends StatelessWidget {
  static String routeName = '/profil_create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(texte: "Mon Profil"),
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
                Container(height: 10),
                ImageInput(),
                Container(height: 10),
                TextInput1(
                  texte: 'Nom*',
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                ),
                Container(height: 10),
                TextInput1(
                  texte: 'Prénom*',
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                ),
                Container(height: 10),
                DateInput1(
                  texte: "Date de naissance",
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Colors.white,
                  ),
                ),
                Container(height: 10),
                NumberInput1(
                  texte: 'Numéros de téléphone',
                  icon: Icon(
                    Icons.phone_android_outlined,
                    color: Colors.white,
                  ),
                ),
                Container(height: 10),
                LocalizationInput1(
                  texte: 'Adresse',
                  icon: Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                  ),
                ),
                Container(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Genre",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: Offset(3, 1),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 5),
                RadiosButtons(
                  buttonsText: [
                    "Homme",
                    "Femme",
                    "Autre",
                  ],
                ),
                Container(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "A propos de moi",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: Offset(3, 1),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                TextInput2(),
                Container(height: 20),
                GradientElevatedButton2(
                  function: () => {
                    Navigator.pushNamed(
                        context, ProfileSportCreateView.routeName)
                  },
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
