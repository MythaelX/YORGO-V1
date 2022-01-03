import 'package:intl/intl.dart';

class PrivateRoom {
  int id;
  int friend_id;
  int? message_autor;
  String? message;
  DateTime? timestamp;

  PrivateRoom(
      {required this.id,
      required this.friend_id,
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
        timestamp = getDate(json['timestamp']);
}
