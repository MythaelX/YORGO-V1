import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/friend/widget/FriendRequestButton.dart';

class FriendAskView extends StatelessWidget {
  const FriendAskView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final List? friendRequests =
        Provider.of<UserProvider>(context).friendRequests;

    return Container(
      child: (friendRequests != null)
          ? Container(
              child: (friendRequests.length != 0)
                  ? Container(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getText(friendRequests.length),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              for (var item in friendRequests)
                                FriendRequestButton(
                                  friend_request_id: item['id'],
                                  friend_id: item['sender_id'],
                                  text: item['sender_username'].toString(),
                                  text2: (item['sender_adress_text'] != null)
                                      ? item['sender_adress_text']
                                      : "",
                                  imageUrl:
                                      getImageUrl(item['sender_profile_image']),
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "Aucune demande d'ami.",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
            )
          : Container(child: Center(child: CircularProgressIndicator())),
    );
  }

  String getText(int length) {
    if (length == 1) {
      return "Vous avez 1 demande d'ami.";
    } else {
      return "Vous avez " + length.toString() + " demandes d'ami.";
    }
  }

  getImageUrl(item) {
    if (item != null && item != "media/default_profile_image.png") {
      return "http://yorgoapi.herokuapp.com/media/" + item;
    } else {
      return null;
    }
  }
}
