import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final Future<void> Function()? submitForm;
  final String text;
  final List<Color> colors;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  const GradientElevatedButton({
    Key? key,
    this.submitForm,
    this.text = "",
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
    this.colors = const [Color(0xff65C5F8), Color(0xff2D93CC)],
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
              color: Colors.white,
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

class GradientElevatedButton2 extends StatelessWidget {
  final void Function()? function;
  final String? text;
  final List<Color>? colors;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final int numberPage;
  final int page;
  final EdgeInsetsGeometry paddingTextPage;

  const GradientElevatedButton2({
    Key? key,
    this.function,
    this.text,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
    this.paddingTextPage =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    this.colors,
    this.numberPage = 0,
    this.page = 0,
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
      onPressed: function,
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors!,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: Stack(
          children: [
            Container(
              padding: padding,
              alignment: Alignment.center,
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: textFontsize,
                  color: Colors.white,
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
            Container(
              padding: paddingTextPage,
              alignment: Alignment.centerRight,
              child: Text(
                '$page / $numberPage',
                style: TextStyle(
                  fontSize: textFontsize,
                  color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
