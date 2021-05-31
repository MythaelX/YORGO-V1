import 'package:flutter/material.dart';
import 'package:yorgo/views/auth/signup_view.dart';

class SigninView extends StatelessWidget {
  static String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            Navigator.pushNamed(context, SignupView.routeName);
          },
          child: const Text('Inscription'),
        ),
      ),
    );
  }
}
