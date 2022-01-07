import 'package:flutter/material.dart';

class GlobalButton1 extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;

  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final int numberPage;
  final int page;
  final EdgeInsetsGeometry paddingTextPage;
  final Color? color;
  const GlobalButton1({
    Key? key,
    this.onPressed,
    this.text,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
    this.paddingTextPage =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    this.numberPage = 0,
    this.page = 0,
    this.color,
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
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
            color: (color == null) ? Theme.of(context).primaryColor : color,
            borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          child: Text(
            text.toString(),
            style: TextStyle(
              fontSize: textFontsize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
