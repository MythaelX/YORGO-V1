import 'package:flutter/widgets.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/models/form/profile_form_model.dart';
import 'package:yorgo/models/form/profile_sport_form_model.dart';
import 'package:yorgo/models/data/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  User? user;
  List<Friend>? listFriend;
  bool isLoading = false;
  late AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (authProvider.isLoggedin != null) {
      if (user == null && authProvider.isLoggedin!) {
        fetchCurrentUser();
        getFriends();
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
          json.decode(utf8.decode(response.bodyBytes)),
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

  void updateFriend(List<Friend> listFriend) {
    listFriend = listFriend;
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
        return json.decode(utf8.decode(response.bodyBytes));
      }
      updateUser(
        User.fromJson(
          json.decode(utf8.decode(response.bodyBytes)),
        ),
      );
      return null;
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }

  Future<dynamic> profileSportCreate(ProfileSportForm profileSportForm) async {
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/api/sports/user/");
      http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'authorization': 'Bearer ${authProvider.tokenAccess}',
        },
        body: json.encode(profileSportForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 201) {
        return json.decode(utf8.decode(response.bodyBytes));
      }
      //update des sports de l'utilisateur.
      String value =
          json.decode(utf8.decode(response.bodyBytes))["sports"].toString();
      user!.sports = getSports(value);

      return null;
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }

  Future getFriends() async {
    Uri url = Uri.parse("$host/api/myfriends/");
    http.Response response = await http.get(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
    );
    if (response.statusCode == 200) {
      Map data = json.decode(utf8.decode(response.bodyBytes));
      List<Friend> friends = [];
      for (var item in data['friends']) {
        Friend friend = Friend.fromJson(item);
        friends.add(friend);
      }

      updateFriend(friends);

      return response.body;
    }

    return null;
  }
}
