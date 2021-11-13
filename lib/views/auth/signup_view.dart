import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/auth/signin_view.dart';
import 'package:yorgo/views/auth/widgets/BackButton.dart';
import 'package:yorgo/widgets/Buttons/BasicElevatedButton.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';

import '../../models/signup_form_model.dart';
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
      final error = await Provider.of<AuthProvider>(context, listen: false)
          .signup(signupForm);
      if (error == null) {
        Navigator.pushNamed(context, SigninView.routeName);
      } else {
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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
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
        fontSize: 54,
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
    if (height < 645) {
      heightResponsive = 645;
    } else {
      heightResponsive = height;
    }
    return SingleChildScrollView(
      child: Container(
        height: heightResponsive,
        child: Stack(
          children: [
            _background(heightResponsive, width),
            BackButtonHome(),
            _signUpContains(context),
          ],
        ),
      ),
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
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            _title(),
            _formSignUp(context),
            Expanded(child: Container()),
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
              signupForm.email = newValue!;
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
              signupForm.username = newValue!;
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
              signupForm.password = newValue!;
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
          //submitForm: submitForm,
          text: "S'inscrire avec facebook",
          colors: [Color(0x18ACFE), Color(0xff0062E0)],
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        BasicElevatedButton(
          text: "S'inscrire avec Google",
          //submitForm: submitForm,
        ),
      ],
    );
  }
}
