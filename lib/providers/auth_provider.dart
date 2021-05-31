import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:yorgo/models/signup_form_model.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2';
  bool isLoading = false;

  Future<dynamic> signup(SignupForm signupForm) async {
    try {
      isLoading = true;
      Uri url = "$host/api/user" as Uri;
      http.Response response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(signupForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }
}
