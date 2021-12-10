import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleAuth extends StatelessWidget {
  final double fontSize;
  final String text;

  const TitleAuth({
    Key? key,
    this.fontSize = 60,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(1),
            offset: Offset(2, 1),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}
