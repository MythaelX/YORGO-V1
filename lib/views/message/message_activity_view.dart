import 'package:flutter/material.dart';

class MessageActivityView extends StatelessWidget {
  const MessageActivityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [Text("MessageActivityView"), Text("message des activités")],
      ),
    );
  }
}
