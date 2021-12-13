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
        children: [Text("Groupes"), Text("message des groupes")],
      ),
    );
  }
}
