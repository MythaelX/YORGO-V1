import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

import '../home/home_views.dart';

class ProfileView extends StatelessWidget {
  static String routeName = '/profil';

  @override
  Widget build(BuildContext context) {
    //Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: HeaderAppBar(texte: "Yorgo"),
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
        child: CircularProgressIndicator(),
      ),
    );
  }
}
