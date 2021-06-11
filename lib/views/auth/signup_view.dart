import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/auth/signin_view.dart';
import 'package:yorgo/views/auth/widgets/BackButton.dart';
import 'package:yorgo/views/auth/widgets/BasicElevatedButton.dart';
import 'package:yorgo/views/auth/widgets/GradientElevatedButton.dart';

import '../../models/signup_form_model.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  SignupForm signupForm;
  FormState get form => key.currentState;

  @override
  void initState() {
    signupForm = SignupForm(email: null, username: null, password: null);
    super.initState();
  }

  Future<void> submitForm() async {
    if (form.validate()) {
      form.save();
      Provider.of<AuthProvider>(context, listen: false).signup(signupForm);
      final error = null;
      if (error == null) {
        Navigator.pushNamed(context, SigninView.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _body(height, width, context),
    );
  }

  Image _background(double height, double width) {
    return Image.asset(
      'assets/images/escalade.jpg',
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }

  Text _title() {
    return Text(
      'Inscription',
      textAlign: TextAlign.center,
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

  Stack _body(double height, double width, BuildContext context) {
    return Stack(
      children: [
        _background(height, width),
        BackButtonHome(),
        _signUpContains(context),
      ],
    );
  }

  Center _signUpContains(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
        padding: EdgeInsets.only(top: 50, bottom: 10, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
            ),
            _title(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            _formSignUp(context),
            Expanded(child: Container()),
            Text(
              "En continuant vous acceptez notre Termes et Politique de confidentialité ",
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
          ],
        ),
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
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: Offset(3, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            onSaved: (newValue) {
              signupForm.email = newValue;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              hintText: 'username',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: Offset(3, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            onSaved: (newValue) {
              signupForm.username = newValue;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              hintText: 'password',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: Offset(3, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            onSaved: (newValue) {
              signupForm.password = newValue;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          _signUpFormButtons(),
        ],
      ),
    );
  }

  Column _signUpFormButtons() {
    return Column(
      children: [
        GradientElevatedButton(
          submitForm: submitForm,
          text: "S'inscrire",
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
          submitForm: submitForm,
          text: "S'inscrire avec facebook",
          colors: [Color(0x18ACFE), Color(0xff0062E0)],
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        BasicElevatedButton(
          text: "S'inscrire avec Google",
          submitForm: submitForm,
        ),
      ],
    );
  }
}
