import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/models/data/room_model.dart';
import 'package:yorgo/models/form/profile_form_model.dart';
import 'package:yorgo/models/form/profile_sport_form_model.dart';
import 'package:yorgo/models/data/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  User? user;
  Account? account;
  List<Friend>? listFriend;
  List? friendRequests;
  bool isLoading = false;
  late AuthProvider authProvider;

  void signout() {
    user = null;
    account = null;
    listFriend = null;
    friendRequests = null;
  }

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

  void updateOtherUser(Account updatedAccount) {
    account = updatedAccount;
    notifyListeners();
  }

  void updateFriend(
      List<Friend> updatedListFriend, List updatedfriendRequests) {
    listFriend = updatedListFriend;
    friendRequests = updatedfriendRequests;
    notifyListeners();
  }

  Future<dynamic> profileCreate(ProfileForm profileForm) async {
    profileForm.is_profile_complete = true;
    try {
      var options = BaseOptions(
        baseUrl: 'https://yorgoapi.herokuapp.com',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Content-type': 'application/json',
          'authorization': 'Bearer ${authProvider.tokenAccess}',
        },
      );

      Dio dio = Dio(options);
      isLoading = true;

      FormData formdata = FormData();
      profileForm.toMap().forEach((key, value) {
        if (value != null) {
          formdata.fields.add(MapEntry(key, value.toString()));
        }
      });
      if (profileForm.profile_image != null) {
        formdata.files
            .add(MapEntry("profile_image", profileForm.profile_image!));
      }
      Response response = await dio.post('/api/user/', data: formdata);

      isLoading = false;
      if (response.statusCode != 201) {
        return response.data;
      }

      updateUser(
        User.fromJson(
          response.data,
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
      user!.sports = User.getSports(value);

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
      List friendRequests = data['friend_requests'];
      for (var item in data['friends']) {
        Friend friend = Friend.fromJson(item);
        friends.add(friend);
      }

      updateFriend(friends, friendRequests);

      return response.body;
    }
  }

  Future friendRequestDecline(int friend_request_id) async {
    Map<String, String> mapFriendRequestDecline = {};
    Uri url = Uri.parse("$host/api/myfriends/");
    mapFriendRequestDecline['action'] = "friend_request_decline";
    mapFriendRequestDecline['friend_request_id'] = friend_request_id.toString();

    http.Response response = await http.post(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
      body: mapFriendRequestDecline,
    );

    if (response.statusCode == 200) {
      Map data = json.decode(utf8.decode(response.bodyBytes));
      List<Friend>? friends = this.listFriend;
      List friendRequests = data['data'];

      updateFriend(friends!, friendRequests);

      return null;
    }

    return "error";
  }

  Future friendRequestAccept(int friend_request_id) async {
    Map<String, String> mapFriendRequestAccept = {};
    Uri url = Uri.parse("$host/api/myfriends/");
    mapFriendRequestAccept['action'] = "friend_request_accept";
    mapFriendRequestAccept['friend_request_id'] = friend_request_id.toString();

    http.Response response = await http.post(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
      body: mapFriendRequestAccept,
    );

    if (response.statusCode == 200) {
      Map data = json.decode(utf8.decode(response.bodyBytes));
      List<Friend>? friends = [];
      for (var item in data['friends']) {
        Friend friend = Friend.fromJson(item);
        friends.add(friend);
      }

      List friendRequests = data['friend_request'];

      updateFriend(friends, friendRequests);

      return response.body;
    }

    return null;
  }

  Future friendRemove(int friend_id) async {
    Map<String, String> mapFriendRequestDecline = {};
    Uri url = Uri.parse("$host/api/myfriends/");
    mapFriendRequestDecline['action'] = "friend_remove";
    mapFriendRequestDecline['friend_id'] = friend_id.toString();

    http.Response response = await http.post(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
      body: mapFriendRequestDecline,
    );

    if (response.statusCode == 200) {
      Map data = json.decode(utf8.decode(response.bodyBytes));
      List<Friend>? friends = [];
      for (var item in data['friends']) {
        Friend friend = Friend.fromJson(item);
        friends.add(friend);
      }

      List? friendRequests = this.friendRequests;

      updateFriend(friends, friendRequests!);

      return response.body;
    }

    return null;
  }

  Future friendSendDemand(int user_receiver_id) async {
    Map<String, String> mapFriendRequest = {};
    Uri url = Uri.parse("$host/api/myfriends/");
    mapFriendRequest['action'] = "friend_request_send";
    mapFriendRequest['user_receiver_id'] = user_receiver_id.toString();

    http.Response response = await http.post(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
      body: mapFriendRequest,
    );

    if (response.statusCode == 201) {
      account!.pending_friend_request_id = json.decode(response.body)['data'];
      return null;
    }

    return response.body;
  }

  Future getUserInformation(int id) async {
    //this.otherUser = null;
    Uri url = Uri.parse("$host/api/user/" + id.toString());
    http.Response response = await http.get(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
    );

    if (response.statusCode != 200) {
      return "error";
    } else {
      updateOtherUser(
          Account.fromJson(json.decode(utf8.decode(response.bodyBytes))));
      return null;
    }
  }

  Future getUsersByQuery(String query) async {
    //this.otherUser = null;
    Uri url = Uri.parse("$host/api/user/search?queryWord=" + query);
    http.Response response = await http.get(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
    );

    if (response.statusCode != 200) {
      return null;
    } else {
      var accounts = json.decode(utf8.decode(response.bodyBytes))["accounts"];
      List<Account> listAccount = [];
      for (var account in accounts) {
        listAccount.add(Account.fromJson2(account));
      }
      return listAccount;
    }
  }
}
