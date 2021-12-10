import 'package:flutter/material.dart';
import 'package:yorgo/widgets/Buttons/BasicElevatedButton.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';

class SignUpFormButtons extends StatelessWidget {
  final Future<void> Function()? submitForm;
  const SignUpFormButtons({
    Key? key,
    this.submitForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientElevatedButton(
          onPressed: submitForm,
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
