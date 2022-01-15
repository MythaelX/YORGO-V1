import 'package:yorgo/models/form/utils_form.dart';

class ActivityAddGroupForm {
  String title;
  String? description;
  DateTime? start;
  DateTime? end;
  int? level;
  int? sportId;
  bool handi;
  bool animals;
  bool private;
  String? address_text;
  double? address_long;
  double? address_lat;
  int? minAge;
  int? maxAge;
  int? numberOfParticipant;

  ActivityAddGroupForm({
    required this.title,
    this.start,
    this.end,
    this.description,
    this.level,
    this.sportId,
    required this.handi,
    required this.animals,
    required this.private,
    this.address_text,
    this.address_long,
    this.address_lat,
    this.minAge,
    this.maxAge,
    this.numberOfParticipant,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'start': getDateString(start),
      'end': getDateString(end),
      'description': description,
      'sportlevel': level,
      'sport': sportId,
      'handi_accept': handi,
      'animals_accept': animals,
      'is_private': private,
      'is_active': true,
      'address_text': address_text,
      'address_long': address_long,
      'address_lat': address_lat,
      'minAge': minAge,
      'maxAge': maxAge,
      'numberOfLimitParticipant': numberOfParticipant,
      'numberOfParticipant': 1,
      'users': [],
    };
  }
}
