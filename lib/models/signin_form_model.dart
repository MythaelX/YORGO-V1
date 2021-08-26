import 'package:flutter/widgets.dart';

class SigninForm {
  String username;
  String password;
  SigninForm({
    @required this.username,
    @required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
