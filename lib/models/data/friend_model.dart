import 'package:yorgo/models/data/utils_model.dart';

class Friend {
  int id;
  String username;
  String? profile_image;
  String? address_text;

  Friend(
      {required this.id,
      required this.username,
      this.profile_image,
      this.address_text});

  Friend.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        profile_image = getImageUser2(json['profile_image']),
        address_text = json['address_text'];
}
