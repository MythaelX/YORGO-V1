import 'package:flutter/material.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class ActivityCreateAloneView extends StatelessWidget {
  static String routeName = '/activity_create_alone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        text: "NOUVELLE ACTIVITÉ",
        fontSize: 30,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("seule"),
      ),
    );
  }
}
