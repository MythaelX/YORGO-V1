import 'package:flutter/widgets.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  late User? user;
  late AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (user == null && authProvider.isLoggedin) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    Uri url = Uri.parse("$host/api/user/current");
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
    }
  }

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}
