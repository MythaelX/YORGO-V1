import 'package:intl/intl.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/models/data/utils_model.dart';

class Activity {
  int id;
  String title;
  int sport;
  int sportLevel;
  int user_id;
  String? username;
  String? userImage;
  DateTime? start;
  DateTime? end;

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
  List<Account>? users;

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
    required this.userImage,
    this.minAge,
    this.maxAge,
    this.numberOfParticipant,
    this.address_text,
    this.address_long,
    this.address_lat,
    this.handi_accept,
    this.animals_accept,
    this.is_private,
    this.users,
  });

  String getDateStartYYYYMMJJ() {
    return DateFormat('yyyy-MM-dd').format(start!);
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
        address_text = json["address_text"],
        address_long = getDouble(json["address_long"]),
        address_lat = getDouble(json["address_lat"]),
        sport = int.parse(json["sport"]),
        sportLevel = int.parse(json["sportlevel"]),
        user_id = int.parse(json["user_id"]);

  Activity.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        is_private = json['is_private'],
        handi_accept = json['handi_accept'],
        animals_accept = json["animals_accept"],
        numberOfParticipant = json["numberOfParticipant"],
        numberOfLimitParticipant = json["numberOfLimitParticipant"],
        start = getDateAndTime3(json["start"]),
        end = getDateAndTime3(json["end"]),
        minAge = json["minAge"],
        maxAge = json["maxAge"],
        address_text = json["address_text"],
        address_long = getDouble(json["address_long"]),
        address_lat = getDouble(json["address_lat"]),
        sport = json["sport"],
        sportLevel = json["sportlevel"],
        users = getUsersFromJson(json["users"]),
        user_id = json["user"]["id"],
        username = json["user"]["username"],
        userImage = getImageUser2(json["user"]["profile_image"])!;

  String getTimeStartEnd() {
    String timeStart =
        DateFormat('HH:mm').format(start!).replaceFirst(":", "h");
    String timeEnd = DateFormat('HH:mm').format(end!).replaceFirst(":", "h");
    return timeStart + " - " + timeEnd;
  }

  String getDateStart() {
    return DateFormat('EEEE dd MMMM', 'FR').format(start!);
  }

  String getLevelText() {
    switch (sportLevel) {
      case 1:
        return "Niveau : Débutant";
      case 2:
        return "Niveau : Intermédiaires";
      case 3:
        return "Niveau : Expert";
      default:
        return "Niveau : inconnue";
    }
  }

  static getUsersFromJson(List listUsersJson) {
    print(listUsersJson);
    List<Account> listUsers = [];
    for (var user in listUsersJson) {
      listUsers.add(Account.fromJson3(user));
    }
    return listUsers;
  }
}
