import 'package:flutter/material.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ActivitySearchView extends StatefulWidget {
  static String routeName = '/activity_search_view';

  @override
  State<ActivitySearchView> createState() => _ActivitySearchViewState();
}

class _ActivitySearchViewState extends State<ActivitySearchView> {
  List<Account> listAccount = [];
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Yorgo",
        elevation: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          "Barre de Recherche bientôt...",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
