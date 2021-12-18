import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/profile/profile_other_view.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class FriendRequestButton extends StatelessWidget {
  final int friend_request_id;
  final int friend_id;
  final String text;
  final String? text2;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorOnSurface;
  final IconData? icon;
  final IconData? icon2;
  final String? imageUrl;

  const FriendRequestButton({
    Key? key,
    required this.friend_request_id,
    required this.friend_id,
    this.text = "",
    this.text2,
    this.imageUrl,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    this.colorPrimary = const Color.fromRGBO(73, 165, 216, 1),
    this.colorOnPrimary = Colors.black,
    this.colorOnSurface = Colors.red,
    this.icon = Icons.clear,
    this.icon2 = Icons.check,
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
        onPressed: () {
          Provider.of<UserProvider>(context, listen: false).account = null;
          Navigator.pushNamed(
            context,
            ProfileOtherView.routeName,
            arguments: ProfileArguments(friend_id),
          );
        },
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
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
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
              width: 55,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.all(0),
                ),
                onPressed: () async {
                  DialogBuilder(context)
                      .showLoadingIndicator('votre demande est en cours.');
                  await Provider.of<UserProvider>(context, listen: false)
                      .friendRequestDecline(this.friend_request_id);
                  DialogBuilder(context).hideOpenDialog();
                },
                child: Icon(
                  icon,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 10,
            ),
            Container(
              width: 55,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(0),
                ),
                onPressed: () async {
                  DialogBuilder(context)
                      .showLoadingIndicator('votre demande est en cours.');
                  await Provider.of<UserProvider>(context, listen: false)
                      .friendRequestAccept(this.friend_request_id);
                  DialogBuilder(context).hideOpenDialog();
                },
                child: Icon(
                  icon2,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 5,
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
