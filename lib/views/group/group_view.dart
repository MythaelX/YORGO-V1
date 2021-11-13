import 'package:flutter/material.dart';

class GroupView extends StatelessWidget {
  static String routeName = '/group';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text("Mes Groupes"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("vue vierge Mes groupes"),
      ),
    );
  }
}
