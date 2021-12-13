import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/activity/my_activity_view.dart';
import 'package:yorgo/views/friend/Friend_view.dart';
import 'package:yorgo/views/group/group_view.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/views/local_sportmen/local_sportmen_view.dart';
import 'package:yorgo/views/setting/settingMenuView.dart';

class NavigationDrawerWidget extends StatelessWidget {
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
              onClicked: () {
                signout(context);
              },
            ),
            Divider(
              color: Colors.white,
              height: 0,
              indent: 0,
              thickness: 1.3,
            ),
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Protection Des Données',
              icon: Icons.shield,
            ),
            buildMenuItem(
              text: 'Conditions Générales',
              icon: Icons.auto_stories,
            ),
            buildMenuItem(
              text: 'Paramètres',
              icon: Icons.settings,
              onClicked: () {
                navigateMenu(context, SettingMenuView.routeName);
              },
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Divider(
                color: Colors.white,
                height: 0,
                indent: 0,
                thickness: 1.4,
              ),
            ),
            const SizedBox(height: 5),
            buildMenuItem(
              text: 'Sportif Du Coin',
              icon: Icons.bolt,
              onClicked: () {
                navigateMenu(context, LocalSportmenView.routeName);
              },
            ),
            buildMenuItem(
              text: 'Mes Activités',
              icon: Icons.analytics_outlined,
              onClicked: () {
                navigateMenu(context, MyActivityView.routeName);
              },
            ),
            buildMenuItem(
              text: 'Mes Groupes',
              icon: Icons.workspaces_outline,
              onClicked: () {
                navigateMenu(context, GroupView.routeName);
              },
            ),
            buildMenuItem(
              text: 'Mes Amis',
              icon: Icons.people,
              onClicked: () {
                navigateMenu(context, FriendView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String? text,
    IconData? icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      title: Text(
        text!,
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

  void signout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).signout();

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeView()), (route) => false);
  }

  void navigateMenu(BuildContext context, String routeName) {
    String? route = ModalRoute.of(context)!.settings.name;
    if (route != routeName) {
      Navigator.pop(context);
      Navigator.pushNamed(context, routeName);
    }
  }
}
