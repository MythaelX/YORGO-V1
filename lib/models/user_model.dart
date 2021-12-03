import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class User {
  String username;
  String email;
  String? firstname;
  String? lastname;
  DateTime? bith;
  String? phone;
  String? address_text;
  double? address_long;
  double? address_lat;
  int? gender;
  String? description;
  bool is_profile_complete;
  Image? profile_image;
  Map? sports;

  User({
    required this.username,
    required this.email,
    this.firstname,
    this.lastname,
    this.bith,
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

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        bith = getDateBirthUser(json['bith']),
        phone = json['phone'],
        address_text = json['address_text'],
        address_long = getDouble(json['address_long']),
        address_lat = getDouble(json['address_lat']),
        gender = json['gender'],
        description = json['description'],
        is_profile_complete = json['is_profile_complete'],
        profile_image = getImageUser((json['profile_image'])),
        sports = getSports(json['sports']);
}

Image? getImageUser(String? image) {
  if (image != null) {
    return Image.memory(base64Decode(image));
  } else {
    return null;
  }
}

DateTime? getDateBirthUser(String? date) {
  if (date != null) {
    return DateFormat('yyyy-MM-dd').parse(date);
  } else {
    return null;
  }
}

double? getDouble(String? value) {
  if (value != null) {
    return double.parse(value);
  } else {
    return null;
  }
}

Map? getSports(String? value) {
  if (value != null) {
    try {
      return json.decode(value);
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}
