import 'package:flutter/material.dart';
import 'package:yorgo/iconCustom/sport_icons.dart';

class TextWhite extends StatelessWidget {
  final String text;
  final double textFontsize;
  final TextAlign textAlign;
  const TextWhite({
    Key? key,
    this.text = "",
    this.textFontsize = 30,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.white,
        fontSize: textFontsize,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(1),
            offset: Offset(0, 2),
            blurRadius: 15,
          ),
        ],
      ),
    );
  }
}

class TextWhiteIcon extends StatelessWidget {
  final String text;
  final double textFontsize;
  final Alignment alignment;
  final IconData? icon;

  const TextWhiteIcon({
    Key? key,
    this.text = "",
    this.textFontsize = 30,
    this.alignment = Alignment.centerLeft,
    this.icon = SportIcons.american_football,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Align(
      alignment: alignment,
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 1.0,
                    top: 2.0,
                    child: Icon(
                      this.icon,
                      color: Colors.black87,
                      size: 30,
                    ),
                  ),
                  Icon(
                    this.icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
            TextSpan(
              text: " " + text,
              style: TextStyle(
                color: Colors.white,
                fontSize: textFontsize,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(1),
                    offset: Offset(0, 2),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
