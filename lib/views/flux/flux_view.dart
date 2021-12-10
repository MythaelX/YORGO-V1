import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yorgo/widgets/menus/navigation_drawer_widget.dart';

class FluxView extends StatelessWidget {
  static String routeName = '/flux';

  @override
  Widget build(BuildContext context) {
//Provider.of<UserProvider>(context).user;
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
        child: Text("Flux vue vide"),
      ),
    );
  }
}
