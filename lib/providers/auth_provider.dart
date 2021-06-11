import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:yorgo/models/signin_form_model.dart';
import 'package:yorgo/models/signup_form_model.dart';
import 'dart:convert';

import 'package:yorgo/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2:8000';
  String token;
  bool isLoading = false;

  Future<dynamic> signup(SignupForm signupForm) async {
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/users/");
      http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Basic YWRtaW46YWRtaW4=',
        },
        body: json.encode(signupForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }

  Future<dynamic> signin(SigninForm signinForm) async {
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/api/auth");
      http.Response response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          signinForm.toJson(),
        ),
      );
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        final User user = User.fromJson(body['user']);
        token = body['token'];
        return user;
      } else {
        return body;
      }
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }
}
