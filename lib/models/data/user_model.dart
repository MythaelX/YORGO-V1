import 'dart:convert';
import 'package:yorgo/models/data/utils_model.dart';

class User {
  String username;
  String email;
  String? firstname;
  String? lastname;
  DateTime? birth;
  String? phone;
  String? address_text;
  double? address_long;
  double? address_lat;
  int? gender;
  String? description;
  bool is_profile_complete;
  String? profile_image;
  Map<String, int>? sports;

  User({
    required this.username,
    required this.email,
    this.firstname,
    this.lastname,
    this.birth,
    this.phone,
    this.address_text,
    this.address_long,
    this.address_lat,
    this.gender,
    this.description,
    required this.is_profile_complete,
    this.profile_image,
    this.sports,
  });

  getGenderString() {
    switch (this.gender) {
      case 0:
        return "Homme";
      case 1:
        return "Femme";
      default:
        return "Neutre";
    }
  }

  getAgeString() {
    if (birth != null) {
      Duration year = DateTime.now().difference(birth!);

      return (year.inDays ~/ 365).toString() + " ans";
    }
    return "Information non renseigné";
  }

  getAdressString() {
    if (address_text != null) {
      return address_text;
    }
    return "Information non renseigné";
  }

  static Map<String, int>? getSports(String? value) {
    Map<String, int> mapfinal;
    if (value != null) {
      mapfinal = {};
      try {
        Map valueMap = json.decode(value);
        valueMap.forEach((key, value) {
          mapfinal[key] = value;
        });
        return mapfinal;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        birth = getDate(json['birth']),
        phone = json['phone'],
        address_text = json['address_text'],
        address_long = getDouble(json['address_long']),
        address_lat = getDouble(json['address_lat']),
        gender = json['gender'],
        description = json['description'],
        is_profile_complete = json['is_profile_complete'],
        profile_image = getImageUser(json['profile_image']),
        sports = getSports(json['sports']);

  User.fromJson2(Map<String, dynamic> json)
      : username = json['username'],
        email = "",
        firstname = json['firstname'],
        lastname = json['lastname'],
        birth = getDate(json['birth']),
        phone = json['phone'],
        address_text = json['address_text'],
        address_long = getDouble(json['address_long']),
        address_lat = getDouble(json['address_lat']),
        gender = json['gender'],
        description = json['description'],
        is_profile_complete = true,
        profile_image = getImageUser2(json['profile_image']),
        sports = getSports(json['sports']);
}
