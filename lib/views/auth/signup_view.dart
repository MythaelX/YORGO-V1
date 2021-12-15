import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/form/signin_form_model.dart';
import 'package:yorgo/models/form/signup_form_model.dart';

import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/auth/widgets/BackButton.dart';
import 'package:yorgo/views/auth/widgets/background.dart';
import 'package:yorgo/views/auth/widgets/signUpFormButtons.dart';
import 'package:yorgo/views/auth/widgets/titleAuth.dart';
import 'package:yorgo/views/profile/profile_create_view.dart';
import 'package:yorgo/widgets/FormWidgets/inputText.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late SignupForm signupForm;
  FormState? get form => key.currentState;

  @override
  void initState() {
    signupForm = SignupForm(email: "", username: "", password: "");
    super.initState();
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      DialogBuilder(context).showLoadingIndicator('Inscription en cours ...');
      final error = await Provider.of<AuthProvider>(context, listen: false)
          .signup(signupForm);
      if (error == null) {
        await Provider.of<AuthProvider>(context, listen: false).signin(
            SigninForm(
                username: signupForm.username, password: signupForm.password));
        DialogBuilder(context).hideOpenDialog();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileCreateView()),
          (route) => false,
        );
      } else {
        DialogBuilder(context).hideOpenDialog();
        final snackBar = SnackBar(
          content: const Text("Erreur d'inscription"),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double heightResponsive = 0;
    if (height < 645) {
      heightResponsive = 645;
    } else {
      heightResponsive = height;
    }
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Background(
                width: width,
                path: 'assets/images/fond.jpg',
                height: heightResponsive,
                alignment: Alignment(-0.1, 0),
              ),
              BackButtonHome(),
              _signUpContains(context, heightResponsive),
            ],
          ),
        ),
      ),
    );
  }

  _signUpContains(BuildContext context, double? height) {
    return Container(
      height: height,
      constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
      padding: EdgeInsets.only(top: 30, bottom: 0, left: 30, right: 30),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TitleAuth(text: 'Inscription'),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          _formSignUp(context),
          Expanded(flex: 2, child: Container(height: 28)),
          AutoSizeText(
            "En continuant vous acceptez notre Termes et Politique de confidentialité ",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(1),
                  offset: Offset(3, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
        ],
      ),
    );
  }

  Form _formSignUp(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
          ),
          TextInput3(
            text: 'Email',
            onSaved: (newValue) {
              signupForm.email = newValue!;
            },
            validator: (value) {
              if (value == null || value == "") {
                return 'Veuillez indiquez votre email.';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                  .hasMatch(value)) {
                return 'Entrez une adresse e-mail valide.';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextInput3(
              text: 'username',
              onSaved: (newValue) {
                signupForm.username = newValue!;
              },
              validator: (value) {
                if (value == null || value == "") {
                  return 'Veuillez indiquez votre pseudo.';
                }
                return null;
              }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextInput3(
              text: 'password',
              onSaved: (newValue) {
                signupForm.password = newValue!;
              },
              validator: (value) {
                if (value == null || value == "") {
                  return 'Veuillez indiquez un mot de passe';
                } else if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value)) {
                  return "Utilisez au moins huit caractères au moins 1 majuscule, 1 chiffre et 1 symbole";
                }
                return null;
              }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          SignUpFormButtons(submitForm: submitForm),
        ],
      ),
    );
  }
}
