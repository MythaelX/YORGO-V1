import 'package:flutter/widgets.dart';
import 'package:yorgo/models/data/category_model.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SportProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  List<Sport>? sports;
  Map<int, String> imageSports = {
    1: "assets/images/fond3.jpg",
    2: "assets/images/fond.jpg",
    3: "assets/images/fond.jpg",
    4: "assets/images/fond.jpg",
    5: "assets/images/fond.jpg",
    6: "assets/images/fond.jpg",
    7: "assets/images/fond.jpg",
    8: "assets/images/fond.jpg",
    9: "assets/images/fond.jpg",
    10: "assets/images/fond.jpg",
    11: "assets/images/fond.jpg",
    12: "assets/images/fond.jpg",
    13: "assets/images/fond.jpg",
    14: "assets/images/fond.jpg",
    15: "assets/images/fond.jpg",
    16: "assets/images/fond.jpg",
    17: "assets/images/fond.jpg",
    18: "assets/images/fond.jpg",
    19: "assets/images/fond.jpg",
    20: "assets/images/fond.jpg",
    21: "assets/images/fond.jpg",
    22: "assets/images/fond.jpg",
    23: "assets/images/fond.jpg",
    24: "assets/images/fond.jpg",
    25: "assets/images/fond.jpg",
    26: "assets/images/fond.jpg",
    27: "assets/images/fond.jpg",
    28: "assets/images/fond.jpg",
    29: "assets/images/fond.jpg",
    30: "assets/images/fond.jpg",
    31: "assets/images/fond.jpg",
    32: "assets/images/fond.jpg",
    33: "assets/images/fond.jpg",
    34: "assets/images/fond.jpg",
    35: "assets/images/fond.jpg",
    36: "assets/images/fond.jpg",
    37: "assets/images/fond.jpg",
    38: "assets/images/fond.jpg",
    39: "assets/images/fond.jpg",
    40: "assets/images/fond.jpg",
    41: "assets/images/fond.jpg",
    42: "assets/images/fond.jpg",
    43: "assets/images/fond.jpg",
    44: "assets/images/fond.jpg",
    45: "assets/images/fond.jpg",
    46: "assets/images/fond.jpg",
    47: "assets/images/fond.jpg",
    48: "assets/images/fond.jpg",
    49: "assets/images/fond.jpg",
    50: "assets/images/fond.jpg",
    51: "assets/images/fond.jpg",
    52: "assets/images/fond.jpg",
    53: "assets/images/fond.jpg",
    54: "assets/images/fond.jpg",
    55: "assets/images/fond.jpg",
    56: "assets/images/fond.jpg",
    57: "assets/images/fond.jpg",
    58: "assets/images/fond.jpg",
    59: "assets/images/fond.jpg",
    60: "assets/images/fond.jpg",
  };
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
