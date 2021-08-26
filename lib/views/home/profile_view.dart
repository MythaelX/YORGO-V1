import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/user_provider.dart';

import 'home_views.dart';

class ProfileView extends StatelessWidget {
  static String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final User user = null;//Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          reverse: true,
          children: [
            ListTile(
              tileColor: Theme.of(context).primaryColor,
              title: Text(
                'Deconnexion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signout();
                Navigator.pushNamed(context, HomeView.routeName);
              },
            )
          ],
        ),
      ),
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
            : CircularProgressIndicator(),
      ),
    );
  }
}
