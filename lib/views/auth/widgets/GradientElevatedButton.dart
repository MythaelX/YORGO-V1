import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final Future<void> Function() submitForm;
  final String text;
  final List<Color> colors;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  const GradientElevatedButton({
    Key key,
    this.submitForm,
    this.text,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
    this.colors,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: submitForm,
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: textFontsize,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(3, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
