import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/widgets/navigation_bottom-bar_widget.dart';
import 'package:yorgo/widgets/navigation_drawer_widget.dart';

class FluxView extends StatelessWidget {
  static String routeName = '/flux';

  @override
  Widget build(BuildContext context) {
    final User user = null; //Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("YORGO"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: null,
      body: Container(
        alignment: Alignment.center,
        child: user != null
            ? Text(
                '${user.username}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text("Flux vue vide"),
      ),
    );
  }
}
