import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/widgets/GetImageProfile.dart';

class ImageProfile extends StatelessWidget {
  final String? image;
  final int size;

  final bool shadow;

  const ImageProfile(
      {Key? key, required this.image, required this.size, this.shadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: (shadow)
            ? [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0,
                  spreadRadius: 2,
                  offset: Offset(1, 2),
                )
              ]
            : null,
      ),
      child: ClipOval(
        child: GetImageProfile(
          imageUrl: image,
          size: size.toDouble(),
        ),
      ),
    );
  }
}
