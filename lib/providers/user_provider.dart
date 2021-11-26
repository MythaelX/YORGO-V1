import 'package:flutter/widgets.dart';
import 'package:yorgo/models/profile_form_model.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  User? user;
  bool isLoading = false;
  late AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (authProvider.isLoggedin != null) {
      if (user == null && authProvider.isLoggedin!) {
        fetchCurrentUser();
      }
    }
  }

  Future fetchCurrentUser() async {
    Uri url = Uri.parse("$host/api/user/");
    http.Response response = await http.get(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
    );
    if (response.statusCode == 200) {
      updateUser(
        User.fromJson(
          json.decode(response.body),
        ),
      );

      return response.body;
    }
    authProvider.isLoggedin = false;
    return null;
  }

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }

  Future<dynamic> profileCreate(ProfileForm profileForm) async {
    profileForm.is_profile_complete = true;
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/api/user/");
      http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'authorization': 'Bearer ${authProvider.tokenAccess}',
        },
        body: json.encode(profileForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 201) {
        return json.decode(response.body);
      }
      updateUser(
        User.fromJson(
          json.decode(response.body),
        ),
      );

      return null;
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }
}
