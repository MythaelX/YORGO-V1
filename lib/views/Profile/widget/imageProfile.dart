import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  final String? image;
  final int height;

  const ImageProfile({
    Key? key,
    required this.image,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = getImage();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15.0,
            spreadRadius: 2,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: ClipOval(
        child: image,
      ),
    );
  }

  getImage() {
    if (image != null) {
      return Image.network(
        image!,
        height: height.toDouble(),
        width: height.toDouble(),
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(
          "assets/images/jogging.jpg",
        ),
        height: height.toDouble(),
        width: height.toDouble(),
        fit: BoxFit.cover,
      );
    }
  }
}
