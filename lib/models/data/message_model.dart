import 'package:yorgo/models/data/utils_model.dart';

class Message {
  String message;
  String natural_timestamp;
  String? profile_image;
  bool isMe;
  bool showTime;
  DateTime timestamp;
  Message(
      {required this.message,
      required this.natural_timestamp,
      required this.showTime,
      this.profile_image,
      required this.timestamp,
      required this.isMe});

  Message.fromMap(Map<String, dynamic> map)
      : message = map['message'],
        natural_timestamp = map['natural_timestamp'],
        timestamp = map['timestamp'],
        profile_image = getImageUser(map['profile_image']),
        showTime = map['showTime'],
        isMe = map['isMe'];
}
