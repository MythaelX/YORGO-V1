import 'package:yorgo/models/data/utils_model.dart';

class NotificationModel {
  int id;
  String action;
  dynamic from;
  bool is_read;
  String natural_timestamp;
  DateTime timestamp;
  String verb;
  String type;

  NotificationModel(
      {required this.id,
      required this.action,
      required this.from,
      required this.is_read,
      required this.timestamp,
      required this.natural_timestamp,
      required this.verb,
      required this.type});

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['notification_id']),
        action = json['actions']['redirect_url'],
        from = json['from'],
        is_read = getBoolfromString(json['is_read']),
        timestamp = getDateTimeFromString(json['timestamp']),
        natural_timestamp = json['natural_timestamp'],
        verb = json['verb'],
        type = json['notification_type'];
}
