import 'package:flutter/widgets.dart';
import 'package:yorgo/models/category_model.dart';
import 'package:yorgo/models/sport_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SportProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  List<Sport>? sports;
  Map? categorys;
  bool isLoading = false;
  late AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (authProvider.isLoggedin != null) {
      if (sports == null && authProvider.isLoggedin!) {
        GetAllCategorys();
        GetAllSports();
      }
    }
  }

  void updateSports(List<Sport> updatedSports) {
    sports = updatedSports;
    notifyListeners();
  }

  void updateCategorys(Map updatedCategorys) {
    categorys = updatedCategorys;
    notifyListeners();
  }

  Future<dynamic> GetAllCategorys() async {
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/api/categorys");
      http.Response response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'authorization': 'Bearer ${authProvider.tokenAccess}',
        },
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      }
      Map categorys = {};
      List<dynamic> values = json.decode(utf8.decode(response.bodyBytes));

      for (var value in values) {
        var category = Category.fromJson(value);
        categorys[category.id] = category;
      }
      if (categorys.isNotEmpty) {
        updateCategorys(categorys);
      }
      return null;
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }

  Future<dynamic> GetAllSports() async {
    try {
      isLoading = true;
      Uri url = Uri.parse("$host/api/sports");
      http.Response response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'authorization': 'Bearer ${authProvider.tokenAccess}',
        },
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      }
      List<Sport> sports = [];
      List<dynamic> values = json.decode(utf8.decode(response.bodyBytes));

      for (var value in values) {
        sports.add(Sport.fromJson(value));
      }
      if (sports.isNotEmpty) {
        updateSports(sports);
      }
      return null;
    } catch (e) {
      isLoading = false;
      return "error";
    }
  }
}
