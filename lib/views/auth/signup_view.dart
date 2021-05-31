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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Inscription',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade900,
                      filled: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      signupForm.email = newValue;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Text(
                    'username',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade900,
                      filled: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      signupForm.username = newValue;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Text(
                    'password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade900,
                      filled: true,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      signupForm.password = newValue;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: submitForm,
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
