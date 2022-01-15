import 'package:flutter/widgets.dart';
import 'package:yorgo/models/form/activity_add_alone_form_model.dart';
import 'package:yorgo/models/form/activity_add_group_form_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityProvider with ChangeNotifier {
  final String host = 'https://yorgoapi.herokuapp.com';
  bool isLoading = false;
  late AuthProvider authProvider;
  List? globalCategory;
  List? globalCategoryActivity;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (authProvider.isLoggedin != null) {
      if (authProvider.isLoggedin!) {
        getactivityGlobalListCategory();
      }
    }
  }

  Future<dynamic> activityAddAlone(
      ActivityAddAloneForm activityAddAloneForm) async {
    Uri url = Uri.parse("$host/api/activity/createAlone/");

    http.Response response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'authorization': 'Bearer ${authProvider.tokenAccess}'
      },
      body: json.encode(activityAddAloneForm.toJson()),
    );

   // var data = utf8.decode(response.bodyBytes);
    if (response.statusCode == 201) {
      return null;
    }

    return "error";
  }

  Future<dynamic> activityAddGroup(
      ActivityAddGroupForm activityAddGroupForm) async {
    Uri url = Uri.parse("$host/api/activity/createGroup/");

    http.Response response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'authorization': 'Bearer ${authProvider.tokenAccess}'
      },
      body: json.encode(activityAddGroupForm.toJson()),
    );

    //var data = utf8.decode(response.bodyBytes);
    if (response.statusCode == 201) {
      return null;
    }
    return "error";
  }

  Future<dynamic> getactivityGlobalListCategory() async {
    Uri url = Uri.parse("$host/api/activity/getGlobaleactivity/");

    http.Response response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'authorization': 'Bearer ${authProvider.tokenAccess}'
      },
    );

    if (response.statusCode == 200) {
      globalCategory = json.decode(utf8.decode(response.bodyBytes))["category"];
      //On récupère les 3 premieres valeur des globalCategory
      var pageNumber = 1;
      globalCategoryActivity = [];
      for (var i = 0; i < 3; i++) {
        Map category = globalCategory![i];
        String key = category.keys.elementAt(0);
        int idCategory = category[key];
        getActivityBySportOrCategory(pageNumber, idCategory);
      }
      return null;
    }
    return "error";
  }

  Future<dynamic> getActivityBySportOrCategory(
      int? pageNumber, int idCategory) async {
    String urlString = "";
    if (idCategory == -1) {
      urlString = "$host/api/activity/getActivityBySportOrCategory?id=" +
          idCategory.toString();
    } else {
      urlString = "$host/api/activity/getActivityBySportOrCategory?id=" +
          idCategory.toString() +
          "&page_number=" +
          pageNumber.toString();
    }
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'authorization': 'Bearer ${authProvider.tokenAccess}'
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      globalCategoryActivity!.add(data);
      notifyListeners();
      return null;
    }
    return "error";
  }
}
