import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/form/profile_form_model.dart';
//model and form
import 'package:yorgo/providers/user_provider.dart';
//View
import 'package:yorgo/views/profile/profile_sport_create.dart';
//Widget common
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';
//Widget Form
import 'package:yorgo/widgets/FormWidgets/InputRadioButton.dart';
import 'package:yorgo/widgets/FormWidgets/inputDate.dart';
import 'package:yorgo/widgets/FormWidgets/inputImage.dart';
import 'package:yorgo/widgets/FormWidgets/inputLocalization.dart';
import 'package:yorgo/widgets/FormWidgets/inputNum.dart';
import 'package:yorgo/widgets/FormWidgets/inputText.dart';
//Widget Bouton
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';

class ProfileCreateView extends StatefulWidget {
  static String routeName = '/profil_create';

  @override
  State<ProfileCreateView> createState() => _ProfileCreateViewState();
}

class _ProfileCreateViewState extends State<ProfileCreateView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late ProfileForm profileForm;
  FormState? get form => key.currentState;

  @override
  void initState() {
    profileForm = ProfileForm(
      lastname: "",
      firstname: "",
      gender: 0,
    );
    super.initState();
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      DialogBuilder(context).showLoadingIndicator('Envoi en cours ...');
      final error = await Provider.of<UserProvider>(context, listen: false)
          .profileCreate(profileForm);
      DialogBuilder(context).hideOpenDialog();
      if (error == null) {
        Navigator.pushNamed(context, ProfileSportCreateView.routeName);
      } else {
        final snackBar = SnackBar(
          content: const Text("Erreur d'envoie du formulaire"),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

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
          child: Form(
            key: key,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(height: 10),
                  ImageInput(onSaved: (File? newValue) async {
                    profileForm.profile_image = await MultipartFile.fromFile(
                        newValue!.path,
                        filename: newValue.path.split('/').last);
                  }),
                  Container(height: 10),
                  TextInput1(
                    texte: 'Nom*',
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      profileForm.lastname = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Veuillez indiquez un nom.';
                      }
                      return null;
                    },
                  ),
                  Container(height: 10),
                  TextInput1(
                    texte: 'Prénom*',
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      profileForm.firstname = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Veuillez indiquez un prénom.';
                      }
                      return null;
                    },
                  ),
                  Container(height: 10),
                  DateInput1(
                    texte: "Date de naissance",
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      if (newValue != "") {
                        profileForm.birth = DateFormat('yyyy / MM / dd')
                            .parse(newValue!)
                            .toString();
                      }
                    },
                  ),
                  Container(height: 10),
                  NumberInput1(
                    texte: 'Numéros de téléphone',
                    icon: Icon(
                      Icons.phone_android_outlined,
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      if (newValue != "") {
                        profileForm.phone = int.tryParse(newValue!);
                      }
                    },
                    validator: (value) {
                      if (value != "" &&
                          value != null &&
                          !RegExp(r'^\+?1?\d{9,14}$').hasMatch(value)) {
                        return 'Veuillez indiquez un bon numéro.';
                      }
                      return null;
                    },
                  ),
                  Container(height: 10),
                  LocalizationInput1(
                    texte: 'Adresse',
                    icon: Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                    ),
                    onSaved: (newValueText, newValueLat, newValueLong) {
                      profileForm.address_text = newValueText!;
                      profileForm.address_lat = newValueLat!;
                      profileForm.address_long = newValueLong!;
                    },
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
                    formTosave: profileForm,
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
                  TextInput2(
                    onSaved: (newValue) {
                      profileForm.description = newValue!;
                    },
                  ),
                  Container(height: 20),
                  GradientElevatedButton2(
                    function: submitForm,
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
      ),
    );
  }
}
