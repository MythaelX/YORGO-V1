import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/form/signin_form_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/auth/signup_view.dart';
import 'package:yorgo/views/auth/widgets/BackButton.dart';
import 'package:yorgo/views/auth/widgets/background.dart';
import 'package:yorgo/views/auth/widgets/signInFormButtons.dart';
import 'package:yorgo/views/auth/widgets/titleAuth.dart';
import 'package:yorgo/views/splash_view.dart';
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
      await Provider.of<UserProvider>(context, listen: false)
          .update(Provider.of<AuthProvider>(context, listen: false));
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
      body: Container(
        child: Stack(
          children: [
            Background(
              width: width,
              path: 'assets/images/jogging.jpg',
              height: height,
            ),
            BackButtonHome(),
            _signInContains(context, heightResponsive),
          ],
        ),
      ),
    );
  }

  Container _signInContains(BuildContext context, double height) {
    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
      padding: EdgeInsets.only(top: 30, bottom: 0, left: 30, right: 30),
      height: height,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          TitleAuth(text: 'Yorgo'),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          _formSignIn(context),
          Expanded(flex: 2, child: Container()),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 25, color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            validator: (value) {
              if (value == null || value == "") {
                return 'Veuillez indiquez votre pseudo.';
              }
              return null;
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
            validator: (value) {
              if (value == null || value == "") {
                return 'Veuillez indiquez votre mot de passe.';
              }
              return null;
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
          SignInFormButtons(submitForm: submitForm),
        ],
      ),
    );
  }
}
