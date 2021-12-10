import 'package:flutter/material.dart';

class NumberInput1 extends StatelessWidget {
  final String? texte;
  final Icon? icon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;

  const NumberInput1({
    Key? key,
    this.texte,
    this.icon,
    this.onSaved,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        hintText: this.texte,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        icon: icon,
        errorStyle: TextStyle(
          color: Colors.red[900],
          shadows: [
            Shadow(
              color: Colors.white.withOpacity(0.8),
              offset: Offset(2, 1),
              blurRadius: 10,
            ),
          ],
          fontWeight: FontWeight.w700,
          fontSize: 14.0,
        ),
      ),
      keyboardType: TextInputType.number,
      maxLength: 10,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(3, 1),
            blurRadius: 30,
          ),
        ],
      ),
      onSaved: this.onSaved,
      validator: validator,
    );
  }
}
