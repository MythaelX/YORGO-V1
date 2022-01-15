import 'package:flutter/material.dart';

class MyActivityView extends StatelessWidget {
  static String routeName = '/my_activity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text("Mes Activités"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(child: Container()),
            Text(
              "Mes activités",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "Bientôt...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
