import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/message/message_sportsmen_room_view.dart';
import 'package:yorgo/views/profile/profile_other_view.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';
import 'package:yorgo/widgets/buttons/ProfileButton.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

// ignore: must_be_immutable
class FriendButton extends StatefulWidget {
  final Friend friend;

  FriendButton({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  State<FriendButton> createState() => _FriendButtonState();
}

class _FriendButtonState extends State<FriendButton> {
  Future<void> optionProfile() async {
    await showDialog(
      context: this.context,
      builder: (context) => SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.0,
                              spreadRadius: 1,
                              offset: Offset(1, 2),
                            )
                          ]),
                      child: Container(
                        child: Stack(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: ImageProfile(
                                  image: widget.friend.profile_image,
                                  size: 150,
                                  shadow: false,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 187, left: 95, right: 95),
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  child: AutoSizeText(
                                    widget.friend.username,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    minFontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    buttonDialog(
                        text: "Envoyer un message",
                        iconData: Icons.mail_rounded,
                        onPressed: () async {
                          var tokenAccess =
                              Provider.of<AuthProvider>(context, listen: false)
                                  .tokenAccess;
                          DialogBuilder(context)
                              .showLoadingIndicator('Chargement...');
                          var room_id = await Provider.of<NotificationProvider>(
                                  context,
                                  listen: false)
                              .getOrCreateRoomFriend(widget.friend);
                          DialogBuilder(context).hideOpenDialog();
                          if (room_id != null) {
                            Navigator.pushNamed(
                              context,
                              MessageSportsmenRoom.routeName,
                              arguments: PrivateRoomArguments(
                                  IOWebSocketChannel.connect(
                                      "ws://yorgoapi.herokuapp.com/api/chat/" +
                                          room_id.toString() +
                                          "/?token=" +
                                          tokenAccess!),
                                  widget.friend,
                                  room_id),
                            );
                          }
                        }),
                    Container(
                      height: 10,
                    ),
                    buttonDialog(
                        text: "Voir le profil",
                        iconData: Icons.person_rounded,
                        onPressed: () {
                          Provider.of<UserProvider>(context, listen: false)
                              .account = null;
                          Navigator.pushNamed(
                            context,
                            ProfileOtherView.routeName,
                            arguments: IdArguments(widget.friend.id),
                          );
                        }),
                    Container(
                      height: 10,
                    ),
                    buttonDialog(
                        text: "Supprimer des amis",
                        color: Color(0xffFF7168),
                        iconData: Icons.cancel,
                        textcolor: Colors.white,
                        onPressed: () async {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .friendRemove(widget.friend.id);
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              Positioned(
                top: -8,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel_sharp,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton buttonDialog(
      {String text = "",
      Color textcolor = const Color.fromRGBO(73, 165, 216, 1),
      void Function()? onPressed,
      Color color = Colors.white,
      IconData? iconData}) {
    var icon = Container();
    var prefix = Container();
    if (iconData != null) {
      icon = Container(
          width: 35,
          alignment: Alignment.centerRight,
          child: Icon(
            iconData,
            color: textcolor,
            size: 30,
          ));
      prefix = Container(
        width: 30,
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.blue,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Row(
          children: [
            prefix,
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  height: 25,
                  child: AutoSizeText(
                    text,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: textcolor,
                    ),
                  ),
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ProfileButton(
      text: widget.friend.username,
      text2: widget.friend.address_text,
      imageUrl: widget.friend.profile_image,
      icon: Icons.more_horiz,
      onPressed: optionProfile,
    );
  }
}
