import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GetImageProfile extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final BoxFit fit;
  const GetImageProfile({
    Key? key,
    this.imageUrl,
    this.size = 50,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return getImage(
        imageUrl: imageUrl,
        size: size,
        imageDefaultPath: "assets/images/profile.png");
  }

  getImage({
    String? imageUrl,
    required double size,
    required String imageDefaultPath,
  }) {
    var defaultImage = Image(
      image: AssetImage(
        imageDefaultPath,
      ),
      height: size,
      width: size,
      fit: fit,
    );
    if (imageUrl != null) {
      var image = CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: fit,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => defaultImage,
      );
      return image;
    }
    return defaultImage;
  }
}
