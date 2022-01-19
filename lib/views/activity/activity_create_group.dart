import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/form/activity_add_group_form_model.dart';
import 'package:yorgo/providers/activity_provider.dart';
import 'package:yorgo/views/home/home_main_view.dart';
import 'package:yorgo/widgets/FormWidgets/InputAge.dart';
import 'package:yorgo/widgets/FormWidgets/InputNumInc.dart';
import 'package:yorgo/widgets/FormWidgets/LabeledCheckBox.dart';
import 'package:yorgo/widgets/FormWidgets/inputDate.dart';
import 'package:yorgo/widgets/FormWidgets/inputLocalization.dart';
import 'package:yorgo/widgets/FormWidgets/inputText.dart';
import 'package:yorgo/widgets/InputSport/InputSport.dart';
import 'package:yorgo/widgets/buttons/GlobalButton.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class ActivityCreateGroupView extends StatefulWidget {
  static String routeName = '/activity_create_group';

  @override
  State<ActivityCreateGroupView> createState() =>
      _ActivityCreateGroupViewState();
}

class _ActivityCreateGroupViewState extends State<ActivityCreateGroupView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late ActivityAddGroupForm activityAddGroupForm;
  FormState? get form => key.currentState;
  bool formValidate = true;
  @override
  void initState() {
    activityAddGroupForm = ActivityAddGroupForm(
      title: "",
      minAge: 18,
      maxAge: 99,
      animals: false,
      handi: false,
      private: false,
    );
    super.initState();
  }

  Future<void> submitForm() async {
    form!.validate();
    if (formValidate) {
      form!.save();
      DialogBuilder(context).showLoadingIndicator('Ajout en cours');
      final response =
          await Provider.of<ActivityProvider>(context, listen: false)
              .activityAddGroup(activityAddGroupForm);
      DialogBuilder(context).hideOpenDialog();
      if (response != "error" && response != "errorAuth") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeMainView()),
          (route) => false,
        );
      } else {
        final snackBar = SnackBar(
          content: const Text('Erreur du serveur'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    formValidate = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Nouvelle Activité",
        fontSize: 30,
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Container(
            child: Container(
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
              child: Column(
                children: [
                  Container(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Informations Globales*",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 320,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, top: 20),
                              child: TextInput4(
                                text: "Titre de l'activité",
                                onSaved: (value) {
                                  if (value != null) {
                                    activityAddGroupForm.title = value;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value == "") {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text(
                                            "Veuillez ajouter un titre à l'activité"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    formValidate = false;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextInput4(
                                    text: "Description",
                                    maxLines: 6,
                                    onSaved: (value) {
                                      activityAddGroupForm.description = value;
                                    },
                                  ))),
                          Container(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: DateInput2(
                              texte: "Début",
                              onSaved: (value) {
                                activityAddGroupForm.start = value;
                              },
                              validator: (value) {
                                if (value == null || value == "") {
                                  final snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: const Text(
                                          "Veuillez ajouter une date de début"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  formValidate = false;
                                }
                                return null;
                              },
                            ),
                          )),
                          Container(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: DateInput2(
                                texte: "Fin",
                                onSaved: (value) {
                                  activityAddGroupForm.end = value;
                                },
                                validator: (value) {
                                  if (value == null || value == "") {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text(
                                            "Veuillez ajouter une date de fin"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    formValidate = false;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InputNumInc(
                                texte: "Nombre de participants",
                                onSaved: (value) {
                                  if (value != null && value != "") {
                                    activityAddGroupForm.numberOfParticipant =
                                        int.parse(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InputAge(
                                text: "Age entre",
                                onSaved: (valueMin, valueMax) {
                                  activityAddGroupForm.minAge = valueMin;
                                  activityAddGroupForm.maxAge = valueMax;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sport*",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.only(
                          top: 2.0, bottom: 2.0, left: 10),
                      alignment: Alignment.centerLeft,
                      child: SportInput(
                        text: "Sport",
                        onSaved: (sportId, sportLevel) {
                          activityAddGroupForm.sportId = sportId;
                          activityAddGroupForm.level = sportLevel;
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content:
                                    const Text("Veuillez ajouter un sport"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            formValidate = false;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lieu de Rendez-vous*",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.only(left: 10.0),
                      child: LocalizationInput2(
                        texte: 'Adresse',
                        onSaved: (newValueText, newValueLat, newValueLong) {
                          activityAddGroupForm.address_text = newValueText;
                          activityAddGroupForm.address_lat = newValueLat;
                          activityAddGroupForm.address_long = newValueLong;
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: const Text(
                                    "Veuillez ajouter un lieu de rendez-vous."));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            formValidate = false;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Options",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            LabeledCheckbox(
                              label: 'Handisport',
                              value: activityAddGroupForm.handi,
                              onChanged: (bool? value) {
                                setState(() {
                                  activityAddGroupForm.handi = value!;
                                });
                              },
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              child: Container(
                                color: Colors.grey,
                                height: 2,
                              ),
                            ),
                            LabeledCheckbox(
                              label: 'Animaux',
                              value: activityAddGroupForm.animals,
                              onChanged: (bool? value) {
                                setState(() {
                                  activityAddGroupForm.animals = value!;
                                });
                              },
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              child: Container(
                                color: Colors.grey,
                                height: 2,
                              ),
                            ),
                            LabeledCheckbox(
                              label:
                                  'Activité privée\n(visible uniqument par mes amis)',
                              value: activityAddGroupForm.private,
                              onChanged: (bool? value) {
                                setState(() {
                                  activityAddGroupForm.private = value!;
                                });
                              },
                              padding: EdgeInsets.only(left: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GlobalButton1(
                      text: "Ajouter une activité",
                      onPressed: () => submitForm(),
                    ),
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
