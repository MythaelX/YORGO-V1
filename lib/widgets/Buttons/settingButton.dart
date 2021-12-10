import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final Future<void> Function()? onPressed;
  final String? text;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorOnSurface;
  final IconData? icon;
  const SettingButton({
    Key? key,
    this.onPressed,
    this.text,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    this.colorPrimary = const Color(0xffF1F9FF),
    this.colorOnPrimary = Colors.black,
    this.colorOnSurface = Colors.red,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: colorPrimary,
          onPrimary: colorOnPrimary,
          onSurface: colorOnSurface,
          elevation: 1,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: onPressed,
        child: Stack(
          children: [
            Container(
              padding: padding,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              padding: padding,
              alignment: Alignment.center,
              child: AutoSizeText(
                text!,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
