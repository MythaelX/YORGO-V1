import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bienvenue sur Yorgo',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ],
        ),
      ),
    );
  }
}
