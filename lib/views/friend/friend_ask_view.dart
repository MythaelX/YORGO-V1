import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/providers/user_provider.dart';

class FriendAskView extends StatelessWidget {
  const FriendAskView({
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
          ? Column(
              children: [Text("FriendAskView"), Text("Les demandes d'amitiés")],
            )
          : Container(child: Center(child: CircularProgressIndicator())),
    );
  }
}
