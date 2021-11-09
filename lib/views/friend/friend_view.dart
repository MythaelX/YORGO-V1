import 'package:flutter/material.dart';
import 'package:yorgo/widgets/navigation_drawer_widget.dart';

class FriendView extends StatelessWidget {
  static String routeName = '/friend';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text("Mes Amis"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("vue vierge Mes amis"),
      ),
    );
  }
}
