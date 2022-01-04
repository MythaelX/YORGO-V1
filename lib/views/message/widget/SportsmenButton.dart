import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/models/data/room_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/message/message_sportsmen_room_view.dart';
import 'package:yorgo/widgets/GetImageProfile.dart';

class SportsmenButton extends StatefulWidget {
  final PrivateRoom room;
  final String text;
  final String? text2;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final Color colorPrimary;
  final Color colorOnPrimary;
  final Color colorOnSurface;
  final String? imageUrl;

  const SportsmenButton({
    Key? key,
    required this.room,
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
  State<SportsmenButton> createState() => _SportsmenButtonState();
}

class _SportsmenButtonState extends State<SportsmenButton> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final String? tokenAccess = Provider.of<AuthProvider>(context).tokenAccess;
    final List<Friend>? Listfriend =
        Provider.of<UserProvider>(context).listFriend;
    Friend? friend;
    if (Listfriend != null) {
      friend =
          Listfriend.firstWhere((friend) => friend.id == widget.room.friend_id);

      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: (widget.room.unReadMessageCount == 0)
                  ? widget.colorPrimary
                  : Colors.grey.shade300,
              onPrimary: widget.colorOnPrimary,
              onSurface: widget.colorOnSurface,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0),
          onPressed: () {
            Navigator.pushNamed(
              context,
              MessageSportsmenRoom.routeName,
              arguments: PrivateRoomArguments(
                  IOWebSocketChannel.connect(
                      "ws://yorgoapi.herokuapp.com/api/chat/" +
                          widget.room.id.toString() +
                          "/?token=" +
                          tokenAccess!),
                  friend!,
                  widget.room.id),
            ).then((value) => setState(() {
                  Provider.of<UserProvider>(context, listen: false)
                      .getRoomsFriend();
                }));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                    child: GetImageProfile(
                        imageUrl: friend.profile_image, size: 70)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  height: 70,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            friend.username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          AutoSizeText(
                            getTextTimeMessage(widget.room.timestamp),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                getMessageRoom(widget.room, friend.username),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: (widget.room.unReadMessageCount == 0)
                                    ? TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      )
                                    : TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 38,
                            child: (widget.room.unReadMessageCount != 0)
                                ? Center(
                                    child: Container(
                                    width: 35,
                                    height: 35,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        widget.room.getMessageCountUnread(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))
                                : null,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    } else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }

  String getTextTimeMessage(DateTime? timestamp) {
    if (timestamp != null) {
      if (timestamp.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
        int minute = timestamp.minute;
        if (minute < 10) {
          return timestamp.hour.toString() +
              " h 0" +
              timestamp.minute.toString();
        }
        return timestamp.hour.toString() + " h " + timestamp.minute.toString();
      } else if (timestamp
          .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        var numberOfdays = DateTime.now().difference(timestamp).inDays.toInt();
        return numberOfdays.toString() + " j";
      } else {
        var numberOfWeek =
            DateTime.now().difference(timestamp).inDays.toInt() ~/ 7;
        return numberOfWeek.toString() + " sem";
      }
    }
    return "";
  }

  String getMessageRoom(PrivateRoom room, String usernameFriend) {
    if (room.message == "" && room.message_autor == null) {
      return "";
    }
    if (room.friend_id == room.message_autor) {
      return usernameFriend + ": " + room.message!;
    }
    return "Vous: " + room.message!;
  }
}
