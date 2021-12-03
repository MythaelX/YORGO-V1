import 'dart:convert';

class ProfileSportForm {
  Map<String, int> sports;

  ProfileSportForm({
    required this.sports,
  });

  Map<String, dynamic> toJson() {
    return {
      'sports': json.encode(sports),
    };
  }
}
