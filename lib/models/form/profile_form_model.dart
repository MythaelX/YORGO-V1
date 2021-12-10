import 'dart:convert';
import 'dart:typed_data';

class ProfileForm {
  String lastname;
  String firstname;
  String? birth;
  num? phone;
  String? address_text;
  double? address_long;
  double? address_lat;
  String? description;
  int? gender;
  bool? is_profile_complete;
  Uint8List? profile_image;

  ProfileForm({
    required this.lastname,
    required this.firstname,
    this.birth,
    this.phone,
    this.address_text,
    this.address_long,
    this.address_lat,
    this.gender,
    this.description,
    this.is_profile_complete = false,
    this.profile_image,
  });

  Map<String, dynamic> toJson() {
    return {
      'lastname': lastname,
      'firstname': firstname,
      'birth': birth,
      'phone': phone,
      'address_text': address_text,
      'address_long': address_long,
      'address_lat': address_lat,
      'gender': gender,
      'description': description,
      'is_profile_complete': is_profile_complete,
      'profile_image': getImageUser(profile_image),
    };
  }
}

getImageUser(Uint8List? image) {
  if (image != null) {
    return base64.encode(image);
  } else {
    return null;
  }
}
