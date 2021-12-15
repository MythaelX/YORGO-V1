import 'dart:convert';
import 'dart:typed_data';

class Friend {
  int id;
  String username;
  Uint8List? profile_image;
  String? address_text;

  Friend(
      {required this.id,
      required this.username,
      this.profile_image,
      this.address_text});

  Friend.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        profile_image = getImageUser(json['profile_image']),
        address_text = json['address_text']!;
}

Uint8List? getImageUser(String? image) {
  if (image != null) {
    return base64Decode(image);
  } else {
    return null;
  }
}
