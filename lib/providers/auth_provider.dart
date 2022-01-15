import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yorgo/models/form/signin_form_model.dart';
import 'package:yorgo/models/form/signup_form_model.dart';
import 'dart:convert';

// import 'package:yorgo/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  //final String host = 'http://10.0.2.2:8000';
  final String host = 'https://yorgoapi.herokuapp.com';
  final FlutterSecureStorage storage = FlutterSecureStorage();
  late String? tokenAccess = null;
  late String? tokenRefresh = null;
  bool isLoading = false;
  late bool? isLoggedin = null;
  late Timer timer;

  Future initAuth() async {
    try {
      String? oldtokenRefresh = await storage.read(key: 'tokenRefresh');
      if (oldtokenRefresh == null) {
        isLoggedin = false;
      } else {
        tokenRefresh = oldtokenRefresh;
        await refreshToken();
        if (tokenAccess != null) {
          isLoggedin = true;
          initTimer();
        } else {
          isLoggedin = false;
        }
      }

      notifyListeners();
    } catch (e) {
      return "error init Auth";
    }
  }

  //a changer
  Future<void> refreshToken() async {
    Uri url = Uri.parse("$host/api/token/refresh/");
    Map bodyData = {
      'refresh': tokenRefresh,
    };
    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
        },
        body: utf8.encode(json.encode(bodyData)),
      );
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        tokenAccess = body['access'];
        storage.write(key: 'tokenAccess', value: tokenAccess);
      } else {
        signout();
      }
    } catch (e) {
      signout();
      rethrow;
    }
  }

  Future<dynamic> signup(SignupForm signupForm) async {
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/api/user/register/");
      http.Response response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(signupForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 201) {
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
      Uri url = Uri.parse("$host/api/token/");
      http.Response response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          signinForm.toJson(),
        ),
      );
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        tokenAccess = body['access'];
        tokenRefresh = body['refresh'];
        storage.write(key: 'tokenAccess', value: tokenAccess);
        storage.write(key: 'tokenRefresh', value: tokenRefresh);
        isLoggedin = true;
        //On set un Timer pour refresh le token Access
        initTimer();

        return "OK";
      } else {
        return "errorAuth";
      }
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }

  void signout() {
    isLoggedin = false;
    tokenAccess = "";
    tokenRefresh = "";
    storage.delete(key: 'tokenAccess');
    storage.delete(key: 'tokenRefresh');
    notifyListeners();
  }

  void initTimer() {
    timer = Timer.periodic(Duration(minutes: 15), (timer) {
      refreshToken();
    });
  }
}
