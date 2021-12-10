import 'package:flutter/material.dart';
import 'package:yorgo/views/profile/profile_edit_view.dart';
import 'package:yorgo/views/profile/profile_sport_edit.dart';
import 'package:yorgo/widgets/buttons/settingButton.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class SettingMenuView extends StatelessWidget {
  static String routeName = '/settingMenu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        texte: "Paramètres",
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: ListView(
          children: [
            SettingButton(
              text: "Modifier mon profil",
              icon: Icons.person,
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileEditView.routeName),
            ),
            SettingButton(
              text: "Modifier mes sports",
              icon: Icons.mode_edit_outline_rounded,
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileSportEditView.routeName),
            ),
            SettingButton(
              text: "Avis",
              icon: Icons.message,
            ),
            SettingButton(
              text: "Notifications",
              icon: Icons.edit_notifications,
            ),
            SettingButton(
              text: "Sécurité",
              icon: Icons.security,
            ),
            SettingButton(
              text: "Noter l'application",
              icon: Icons.star,
            ),
            SettingButton(
              text: "Nous faire un retour",
              icon: Icons.mail_outlined,
            ),
            SettingButton(
              text: "Aide",
              icon: Icons.help_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
