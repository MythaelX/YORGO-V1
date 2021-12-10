import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextBlue extends StatelessWidget {
  final String text;
  final double textFontsize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final int? maxLines;
  const TextBlue(
      {Key? key,
      this.text = "",
      this.textFontsize = 30,
      this.textAlign = TextAlign.center,
      this.fontWeight = FontWeight.w700,
      this.maxLines = null})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: textFontsize,
          fontWeight: fontWeight),
    );
  }
}
