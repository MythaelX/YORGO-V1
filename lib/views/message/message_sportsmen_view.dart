import 'package:flutter/material.dart';

class MessageSportsmenView extends StatelessWidget {
  const MessageSportsmenView({
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
          Text("Sports"),
          Text("Message des sportifs"),
        ],
      ),
    );
  }
}
