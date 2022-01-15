import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yorgo/models/data/notification_model.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/friend/friend_home_view.dart';
import 'package:yorgo/widgets/GetImageProfile.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: (notification.is_read == true)
                ? Colors.white
                : Colors.grey.shade300,
            onPrimary: Colors.black,
            onSurface: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(),
            padding: EdgeInsets.zero,
            elevation: 0),
        onPressed: () {
          if (notification.type == "FriendRequest") {
            Navigator.pushNamed(context, FriendHomeView.routeName,
                arguments: FriendArguments(2));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                  child: GetImageProfile(
                      imageUrl: notification.from["profile_image"], size: 70)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                height: 70,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 5,
                      ),
                    ),
                    Container(
                      height: 42,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        notification.verb,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        notification.natural_timestamp,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
