import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/form/activity_add_alone_form_model.dart';
import 'package:yorgo/providers/activity_provider.dart';
import 'package:yorgo/views/home/home_main_view.dart';
import 'package:yorgo/widgets/FormWidgets/inputDate.dart';
import 'package:yorgo/widgets/FormWidgets/inputText.dart';
import 'package:yorgo/widgets/InputSport/InputSport.dart';
import 'package:yorgo/widgets/buttons/GlobalButton.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class ActivityCreateAloneView extends StatefulWidget {
  static String routeName = '/activity_create_alone';

  @override
  State<ActivityCreateAloneView> createState() =>
      _ActivityCreateAloneViewState();
}

class _ActivityCreateAloneViewState extends State<ActivityCreateAloneView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late ActivityAddAloneForm activityAddAloneForm;
  FormState? get form => key.currentState;
  bool formValidate = true;
  @override
  void initState() {
    activityAddAloneForm = ActivityAddAloneForm(
      title: "",
    );
    super.initState();
  }

  Future<void> submitForm() async {
    form!.validate();
    if (formValidate) {
      form!.save();
      DialogBuilder(context).showLoadingIndicator('Ajout en court...');
      final response =
          await Provider.of<ActivityProvider>(context, listen: false)
              .activityAddAlone(activityAddAloneForm);
      DialogBuilder(context).hideOpenDialog();
      if (response != "error" && response != "errorAuth") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeMainView()),
          (route) => false,
        );
      } else {
        final snackBar = SnackBar(
          content: const Text('Erreur de connexion'),
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
    var height = MediaQuery.of(context).size.height;
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
              height: (height < 620) ? 620 : height,
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
                      "Informations Globales",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 300,
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
                              padding: EdgeInsets.only(left: 10),
                              child: TextInput4(
                                text: "Titre de l'activité",
                                onSaved: (value) {
                                  if (value != null) {
                                    activityAddAloneForm.title = value;
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
                            padding: EdgeInsets.all(1),
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
                                      activityAddAloneForm.description = value;
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
                                activityAddAloneForm.start = value;
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
                                  activityAddAloneForm.end = value;
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
                          activityAddAloneForm.sportId = sportId;
                          activityAddAloneForm.level = sportLevel;
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GlobalButton1(text: "Partir mainteant"),
                  // ),
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
