import 'package:flutter/material.dart';

class NumberInput1 extends StatelessWidget {
  final String? texte;
  final Icon? icon;
  const NumberInput1({
    Key? key,
    this.texte,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onSaved: (newValue) {},
    );
  }
}
