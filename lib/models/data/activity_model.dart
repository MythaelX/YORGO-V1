import 'package:intl/intl.dart';
import 'package:yorgo/models/data/utils_model.dart';

class Activity {
  int id;
  String title;
  int sport;
  int sportLevel;
  int user_id;
  DateTime start;
  DateTime end;
  String username;

  String? description;
  int? minAge;
  int? maxAge;
  int? numberOfParticipant;
  String? address_text;
  double? address_long;
  double? address_lat;
  bool? handi_accept;
  bool? animals_accept;
  bool? is_private;
  int? numberOfLimitParticipant;

  Activity({
    required this.title,
    required this.description,
    required this.start,
    required this.end,
    required this.id,
    required this.sport,
    required this.sportLevel,
    required this.user_id,
    required this.username,
    this.minAge,
    this.maxAge,
    this.numberOfParticipant,
    this.address_text,
    this.address_long,
    this.address_lat,
    this.handi_accept,
    this.animals_accept,
    this.is_private,
  });

  String getDateStartYYYYMMJJ() {
    return DateFormat('yyyy-MM-dd').format(start);
  }

  Activity.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['activity_id']),
        title = json['title'],
        description = json['description'],
        is_private = getBoolfromString(json['is_private']),
        handi_accept = getBoolfromString(json['handi_accept']),
        animals_accept = getBoolfromString(json["animals_accept"]),
        numberOfParticipant = int.parse(json["numberOfParticipant"]),
        numberOfLimitParticipant = int.parse(json["numberOfLimitParticipant"]),
        start = getDateAndTime2(json["start"])!,
        end = getDateAndTime2(json["end"])!,
        minAge = int.parse(json["minAge"]),
        maxAge = int.parse(json["maxAge"]),
        address_text = json["address_text"],
        address_long = getDouble(json["address_long"]),
        address_lat = getDouble(json["address_lat"]),
        sport = int.parse(json["sport"]),
        sportLevel = int.parse(json["sportlevel"]),
        user_id = int.parse(json["user_id"]),
        username = json["username"];

  String getTimeStartEnd() {
    String timeStart = DateFormat('HH:mm').format(start).replaceFirst(":", "h");
    String timeEnd = DateFormat('HH:mm').format(end).replaceFirst(":", "h");
    return timeStart + " - " + timeEnd;
  }
}
