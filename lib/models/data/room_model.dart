import 'package:intl/intl.dart';

class PrivateRoom {
  int id;
  int friend_id;
  int? message_autor;
  String? message;
  DateTime? timestamp;
  int unReadMessageCount;

  PrivateRoom(
      {required this.id,
      required this.friend_id,
      required this.unReadMessageCount,
      this.message_autor,
      this.message,
      this.timestamp});

  static DateTime? getDate(String? date) {
    try {
      if (date != null) {
        return DateFormat('yyyy/MM/dd HH:mm:ss').parse(date);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  String getMessageCountUnread() {
    if (this.unReadMessageCount > 99) {
      return "+99";
    } else {
      return this.unReadMessageCount.toString();
    }
  }

  static int? getInt(String? value) {
    try {
      if (value != null) {
        return int.parse(value);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  PrivateRoom.fromJson(Map<String, dynamic> json)
      : id = json['room_id'],
        friend_id = json['friend'],
        message_autor = getInt(json['message_autor'].toString()),
        message = json['message'].toString(),
        unReadMessageCount = json['messageUnRead'],
        timestamp = getDate(json['timestamp']);
}
