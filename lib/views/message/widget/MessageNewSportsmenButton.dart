import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/message/message_sportsmen_room_view.dart';
import 'package:yorgo/widgets/GetImageProfile.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class MessageNewSportsmenButton extends StatelessWidget {
  final Friend friend;
  final String text;
  final String? text2;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorOnSurface;
  final String? imageUrl;

  const MessageNewSportsmenButton({
    Key? key,
    required this.friend,
    this.text = "",
    this.text2,
    this.imageUrl,
    this.textFontsize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    this.colorPrimary = Colors.white,
    this.colorOnPrimary = Colors.black,
    this.colorOnSurface = Colors.white,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final String? tokenAccess = Provider.of<AuthProvider>(context).tokenAccess;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            onPrimary: colorOnPrimary,
            onSurface: colorOnSurface,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            elevation: 0),
        onPressed: () async {
          DialogBuilder(context).showLoadingIndicator('Chargement...');
          var room_id =
              await Provider.of<NotificationProvider>(context, listen: false)
                  .getOrCreateRoomFriend(friend);
          DialogBuilder(context).hideOpenDialog();
          if (room_id != null) {
            await Navigator.pushNamed(
              context,
              MessageSportsmenRoom.routeName,
              arguments: PrivateRoomArguments(
                  IOWebSocketChannel.connect(
                      "ws://yorgoapi.herokuapp.com/api/chat/" +
                          room_id.toString() +
                          "/?token=" +
                          tokenAccess!),
                  friend,
                  room_id),
            );
            Provider.of<NotificationProvider>(context, listen: false)
                .getRoomsFriend();
          } else {
            final snackBar = SnackBar(
              content: const Text("Erreur côté serveur"),
            );
            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                  child: GetImageProfile(
                imageUrl: friend.profile_image,
                size: 70,
              )),
            ),
            AutoSizeText(
              friend.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
