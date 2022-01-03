import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/room_model.dart';
import 'package:yorgo/providers/user_provider.dart';
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
    final Map? listPrivateRoomMap =
        Provider.of<UserProvider>(context).listPrivateRoom;
    if (listPrivateRoomMap == null) {
      Provider.of<UserProvider>(context).getRoomsFriend().then((value) {
        setState(() {});
      });
    }
    return Container(
      child: listPrivateRoomMap != null
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15),
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
                      for (PrivateRoom room in listPrivateRoomMap["listRoom"])
                        SportsmenButton(room: room)
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
          : Container(child: Center(child: CircularProgressIndicator())),
    );
  }
}
