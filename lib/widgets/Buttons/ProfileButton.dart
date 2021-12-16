import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String? text2;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorOnSurface;
  final IconData? icon;
  final String? imageUrl;
  const ProfileButton({
    Key? key,
    this.onPressed,
    this.text = "",
    this.text2,
    this.imageUrl,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    this.colorPrimary = const Color.fromRGBO(73, 165, 216, 1),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: ClipOval(child: getImage(imageUrl, 70)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    AutoSizeText(
                      (text2 != null) ? text2! : "",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 50,
              child: Icon(
                icon,
                size: 35,
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  getImage(String? imageUrl, double size) {
    var defaultImage = Image(
      image: AssetImage(
        "assets/images/jogging.jpg",
      ),
      height: size,
      width: size,
      fit: BoxFit.cover,
    );
    if (imageUrl != null) {
      var image = CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => defaultImage,
      );
      return image;
    }
    return defaultImage;
  }
}
