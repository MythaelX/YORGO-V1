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
    1: "assets/images/football.jpg",
    2: "assets/images/american-football.jpg",
    3: "assets/images/tenis.jpg",
    4: "assets/images/horse.jpg",
    5: "assets/images/judo.jpg",
    6: "assets/images/handball.jpg",
    7: "assets/images/voile.jpg",
    8: "assets/images/other.jpg",
    9: "assets/images/cyclisme.jpg",
    10: "assets/images/swimmer.jpg",
    11: "assets/images/Canoe_kayak.jpg",
    12: "assets/images/jogging.jpg",
    13: "assets/images/gym.jpg",
    14: "assets/images/randonne.jpg",
    15: "assets/images/tenis_de_table.jpg",
    16: "assets/images/badminton.jpg",
    17: "assets/images/basket.jpg",
    18: "assets/images/golf.jpg",
    19: "assets/images/escalade.jpg",
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

  Sport getSportByID(int id) {
    return sports!.firstWhere((sport) => sport.id == id);
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
