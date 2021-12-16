import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/providers/user_provider.dart';

class FriendSearchView extends StatelessWidget {
  const FriendSearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final List<Friend>? listFriend =
        Provider.of<UserProvider>(context).listFriend;
    return Container(
      child: (listFriend != null)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      getNumberFriend(listFriend.length),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("Barre de Recherche"),
                  for (Friend item in listFriend) Text(item.username)
                ],
              ),
            )
          : Container(child: Center(child: CircularProgressIndicator())),
    );
  }

  String getNumberFriend(int length) {
    if (length > 1) {
      return length.toString() + " Amis";
    } else {
      return length.toString() + " Ami";
    }
  }
}
