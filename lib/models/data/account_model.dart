import 'dart:convert';
import 'package:yorgo/models/data/utils_model.dart';

class Account {
  int? id;
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  DateTime? birth;
  String? phone;
  String? address_text;
  double? address_long;
  double? address_lat;
  int? gender;
  String? description;
  String? profile_image;
  Map<String, int>? sports;
  //Friend
  int? request_sent;
  bool? is_friend;
  bool? is_self;
  int? pending_friend_request_id;

  Account({
    required this.id,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.birth,
    this.phone,
    this.address_text,
    this.address_long,
    this.address_lat,
    this.gender,
    this.description,
    this.profile_image,
    this.sports,
    this.request_sent,
    this.is_friend,
    this.is_self,
    this.pending_friend_request_id,
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

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        birth = getDate(json['birth']),
        phone = json['phone'],
        address_text = json['address_text'],
        address_long = getDouble(json['address_long']),
        address_lat = getDouble(json['address_lat']),
        gender = json['gender'],
        description = json['description'],
        profile_image = getImageUser(json['profile_image']),
        sports = getSports(json['sports']),
        request_sent = json['request_sent'],
        is_friend = json['is_friend'],
        is_self = json['is_self'],
        pending_friend_request_id = json['pending_friend_request_id'];

  Account.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        profile_image = getImageUser(json['profile_image']),
        address_text = json['address_text'],
        address_long = getDouble(json['address_long']),
        address_lat = getDouble(json['address_lat']),
        is_friend = json['is_friend'];

  Account.fromJson3(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        profile_image = getImageUser2(json['profile_image']);
}
