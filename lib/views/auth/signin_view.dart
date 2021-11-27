import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/signin_form_model.dart';
/* import 'package:yorgo/models/user_model.dart'; */
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/auth/signup_view.dart';
import 'package:yorgo/views/auth/widgets/BackButton.dart';
import 'package:yorgo/views/auth/widgets/background.dart';
import 'package:yorgo/views/splash_view.dart';
import 'package:yorgo/widgets/Buttons/BasicElevatedButton.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';
import 'package:yorgo/widgets/FormWidgets/inputText.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class SigninView extends StatefulWidget {
  static String routeName = '/signin';

  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late SigninForm signinForm;
  FormState? get form => key.currentState;
  bool hidePassword = true;
  String? error;

  @override
  void initState() {
    signinForm = SigninForm(username: "", password: "");
    super.initState();
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      DialogBuilder(context).showLoadingIndicator('Connexion en cours ...');
      final response = await Provider.of<AuthProvider>(context, listen: false)
          .signin(signinForm);
      DialogBuilder(context).hideOpenDialog();
      if (response != "error" && response != "errorAuth") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SplashView()),
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
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: _body(height, width, context),
    );
  }

  Text _title() {
    return Text(
      'Yorgo',
      style: TextStyle(
        fontSize: 60,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(1),
            offset: Offset(3, 2),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _body(
      double height, double width, BuildContext context) {
    double heightResponsive = 0;
    if (height < 690) {
      heightResponsive = 690;
    } else {
      heightResponsive = height;
    }
    return SingleChildScrollView(
      child: Container(
        height: heightResponsive,
        child: Stack(
          children: [
            Background(
              height: heightResponsive,
              width: width,
              path: 'assets/images/jogging.jpg',
            ),
            BackButtonHome(),
            _signInContains(context),
          ],
        ),
      ),
    );
  }

  Center _signInContains(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
        padding: EdgeInsets.only(top: 50, bottom: 5, left: 30, right: 30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            _title(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            _formSignIn(context),
            Expanded(child: Container()),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25, color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
              child: AutoSizeText(
                "Je n'ai pas de compte",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(1),
                      offset: Offset(3, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form _formSignIn(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
          ),
          TextInput3(
            text: 'Username',
            onSaved: (newValue) {
              signinForm.username = newValue!;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextInputPassword(
            texte: "Mot de passe",
            hidePassword: hidePassword,
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            onSaved: (newValue) {
              signinForm.password = newValue!;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: error != null
                ? Text(
                    error!,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : null,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                /* Navigator.pushNamed(context, SignupView.routeName); */
              },
              child: Text(
                "Mot de passe oublié ?",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(3, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          _signInFormButtons(),
        ],
      ),
    );
  }

  Column _signInFormButtons() {
    return Column(
      children: [
        GradientElevatedButton(
          onPressed: submitForm,
          text: "Se connecter",
          colors: [Color(0xff65C5F8), Color(0xff2D93CC)],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        Text(
          "ou",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.8),
                offset: Offset(3, 2),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        GradientElevatedButton(
          //submitForm: submitForm,
          text: "Connexion avec facebook",
          colors: [Color(0x18ACFE), Color(0xff0062E0)],
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        BasicElevatedButton(
          text: "Connexion avec Google",
          //submitForm: submitForm,
        ),
      ],
    );
  }
}
