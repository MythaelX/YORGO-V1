import 'package:flutter/material.dart';
import 'package:yorgo/models/data/message_model.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';

class MessageContent extends StatelessWidget {
  final Message message;

  const MessageContent({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final Container msg = Container(
      margin: message.isMe
          ? EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
              right: 4.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: message.isMe
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (message.isMe) {
      return Column(children: [
        Container(
          child: (message.showTime == true)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message.natural_timestamp,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                )
              : null,
        ),
        msg,
      ]);
    }
    return Column(
      children: [
        Container(
          child: (message.showTime == true)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message.natural_timestamp,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                )
              : null,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
                padding:
                    const EdgeInsets.only(right: 8.0, left: 3.0, bottom: 4.0),
                child: ImageProfile(
                    size: 35, image: message.profile_image, shadow: false)),
            msg,
          ],
        ),
      ],
    );
  }
}
