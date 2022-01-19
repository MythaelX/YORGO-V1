import 'package:flutter/material.dart';

class BackgroundProfile extends StatelessWidget {
  final Image? image;
  final int height;

  const BackgroundProfile({
    Key? key,
    required this.image,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: getImage(width),
    );
  }

  getImage(double width) {
    if (image != null) {
      return Image(
        image: image!.image,
        height: height.toDouble(),
        width: height.toDouble(),
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(
          "assets/images/fond6.jpg",
        ),
        alignment: Alignment.topCenter,
        height: height.toDouble(),
        width: width,
        fit: BoxFit.cover,
      );
    }
  }
}
