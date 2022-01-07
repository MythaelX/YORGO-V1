import 'package:flutter/material.dart';

class ActivityCreateGroupView extends StatelessWidget {
  static String routeName = '/activity_create_group';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text("creation activité"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("groupe"),
      ),
    );
  }
}
