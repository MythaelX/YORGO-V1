import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/room_model.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:yorgo/views/message/widget/SportsmenButton.dart';

class MessageSportsmenView extends StatefulWidget {
  const MessageSportsmenView({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageSportsmenView> createState() => _MessageSportsmenViewState();
}

class _MessageSportsmenViewState extends State<MessageSportsmenView> {
  String filter = "";

  @override
  Widget build(
    BuildContext context,
  ) {
    final List<PrivateRoom>? listPrivateRoom =
        Provider.of<NotificationProvider>(context).listPrivateRoom;
    final int? messageCount =
        Provider.of<NotificationProvider>(context).countNotReadMessage;
    if (listPrivateRoom == null) {
      Provider.of<NotificationProvider>(context)
          .getRoomsFriend(messageCount: messageCount);
      setState(() {});
    }
    return Container(
        child: (listPrivateRoom != null && listPrivateRoom.length != 0)
            ? SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                  child: Container(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //   child: SearchBar2(
                        //     onChanged: (value) => {
                        //       setState(() {
                        //         filter = value;
                        //       })
                        //     },
                        //   ),
                        // ),
                        for (PrivateRoom room in listPrivateRoom)
                          SportsmenButton(room: room),

                        //FriendButton(friend: item)
                        // ProfileButton(
                        //   text: item.username,
                        //   text2: item.address_text,
                        //   imageUrl: item.profile_image,
                        //   icon: Icons.more_horiz,
                        //   onPressed: () => () {},
                        // )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Container(
                  child:
                      (listPrivateRoom != null && listPrivateRoom.length == 0)
                          ? Text("vous n'avez pas encore d'ami",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500))
                          : CircularProgressIndicator(),
                ),
              ));
  }
}
