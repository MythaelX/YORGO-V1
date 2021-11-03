// ignore_for_file: camel_case_types

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/home/home_views.dart';

class FluxView extends StatelessWidget {
  static String routeName = '/flux';

  @override
  Widget build(BuildContext context) {
    final User user = null; //Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      drawer: navigationDrawerWidget(),
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

class navigationDrawerWidget extends StatelessWidget {
  const navigationDrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: Color.fromRGBO(73, 165, 216, 1),
      child: ListView(
        reverse: true,
        children: <Widget>[
          buildMenuItem(
            text: 'Deconnexion',
            icon: Icons.power_settings_new,
            onClicked: signout(context),
          ),
          Divider(
            color: Colors.white,
            height: 0,
            indent: 0,
            thickness: 1.3,
          ),
          const SizedBox(height: 10),
          buildMenuItem(
            text: 'Protection des données',
            icon: Icons.shield,
          ),
          buildMenuItem(
            text: 'Conditions générales',
            icon: Icons.auto_stories,
          ),
          buildMenuItem(
            text: 'Paramètres',
            icon: Icons.settings,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Divider(
              color: Colors.white,
              height: 0,
              indent: 0,
              thickness: 1.4,
            ),
          ),
          const SizedBox(height: 5),
          buildMenuItem(
            text: 'Sportif du coin',
            icon: Icons.bolt,
          ),
          buildMenuItem(
            text: 'Mes activités',
            icon: Icons.analytics_outlined,
          ),
          buildMenuItem(
            text: 'Mes Groupes',
            icon: Icons.workspaces_outline,
          ),
          buildMenuItem(
            text: 'Mes Amis',
            icon: Icons.people,
          ),
        ],
      ),
    ) /*
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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                  (route) => false);
            },
          )
        ],
      ), */
        );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
    BuildContext context,
    Function onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      hoverColor: hoverColor,
      leading: Icon(
        icon,
        color: color,
      ),
      onTap: onClicked,
    );
  }

  void Function() signout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).signout();
    /* Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeView()), (route) => false); */
    return null;
  }
}
