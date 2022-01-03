import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

import 'widget/MessageNewSportsmenButton.dart';

class MessageNewView extends StatelessWidget {
  static String routeName = '/message_new';

  @override
  Widget build(BuildContext context) {
    final List<Friend>? listFriend =
        Provider.of<UserProvider>(context).listFriend;
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Nouveau message",
      ),
      backgroundColor: Colors.white,
      body: (listFriend != null)
          ? ListView(
              children: [
                for (Friend friend in listFriend)
                  MessageNewSportsmenButton(
                    friend: friend,
                  )
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
