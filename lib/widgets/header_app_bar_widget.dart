import 'package:flutter/material.dart';
import 'package:yorgo/views/setting/settingMenuView.dart';

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? texte;
  final bool backButton;
  final bool config;
  final bool elevation;
  HeaderAppBar(
      {this.texte,
      this.backButton = false,
      this.config = false,
      this.elevation = true});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton ? BackButton(color: Colors.white) : null,
      centerTitle: true,
      title: Text(
        texte!,
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
      actions: config ? [confButton()] : null,
      elevation: elevation ? null : 0,
    );
  }
}

class confButton extends StatelessWidget {
  final color;

  const confButton({
    Key? key,
    this.color = const Color(0xffFFFFFF),
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: color,
        size: 30,
      ),
      onPressed: () =>
          {Navigator.pushNamed(context, SettingMenuView.routeName)},
    );
  }
}
