import 'package:flutter/material.dart';

class BasicElevatedButton extends StatelessWidget {
  final Future<void> Function() submitForm;
  final String text;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorOnSurface;
  const BasicElevatedButton({
    Key key,
    this.submitForm,
    this.text,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    this.colorPrimary = Colors.white,
    this.colorOnPrimary = Colors.black,
    this.colorOnSurface = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: colorPrimary,
        onPrimary: colorOnPrimary,
        onSurface: colorOnSurface,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: submitForm,
      child: Container(
        padding: padding,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
