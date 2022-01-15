import 'package:yorgo/models/form/utils_form.dart';

class ActivityAddAloneForm {
  String title;
  String? description;
  DateTime? start;
  DateTime? end;
  int? level;
  int? sportId;

  ActivityAddAloneForm({
    required this.title,
    this.start,
    this.end,
    this.description,
    this.level,
    this.sportId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'start': getDateString(start),
      'end': getDateString(end),
      'description': description,
      'sportlevel': level,
      'sport': sportId,
      'is_active': true,
    };
  }
}
