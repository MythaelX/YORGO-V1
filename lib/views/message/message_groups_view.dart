import 'package:flutter/material.dart';

class MessageGroupsView extends StatelessWidget {
  const MessageGroupsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(child: Container()),
          Text(
            "Messagerie des Groupes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            "Bientôt...",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
