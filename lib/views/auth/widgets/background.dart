import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final double height;
  final double width;
  final String path;
  final Alignment alignment;
  const Background({
    Key? key,
    required this.path,
    required this.height,
    required this.width,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      alignment: alignment,
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
