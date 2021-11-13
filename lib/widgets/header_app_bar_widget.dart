import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? texte;
  final bool backButton;
  HeaderAppBar({this.texte, this.backButton = false});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton ? BackButton(color: Colors.white) : null,
      centerTitle: true,
      title: Text(texte!),
    );
  }
}
