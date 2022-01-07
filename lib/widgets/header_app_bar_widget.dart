import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? text;
  final String? textImage;
  final bool backButton;
  final bool config;
  final String? configRouteName;
  final Widget? configIcon;
  final double fontSize;

  final bool elevation;
  HeaderAppBar(
      {this.text,
      this.textImage,
      this.backButton = false,
      this.config = false,
      this.configRouteName,
      this.fontSize = 35,
      this.configIcon = const Icon(
        Icons.settings,
        color: Colors.white,
        size: 30,
      ),
      this.elevation = true});

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton ? BackButton(color: Colors.white) : null,
      centerTitle: true,
      title: (textImage == null)
          ? AutoSizeText(
              text!,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 3.0, bottom: 4.0),
                  child:
                      ImageProfile(size: 35, image: textImage, shadow: false),
                ),
                AutoSizeText(
                  text!,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: (config && configRouteName != null)
          ? [
              confButton(
                  configRouteName: configRouteName!, configIcon: configIcon!)
            ]
          : null,
      elevation: elevation ? null : 0,
    );
  }
}

class confButton extends StatelessWidget {
  final Color color;
  final String configRouteName;
  final Widget configIcon;
  const confButton({
    Key? key,
    this.color = const Color(0xffFFFFFF),
    required this.configIcon,
    required this.configRouteName,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return IconButton(
      icon: configIcon,
      onPressed: () => {Navigator.pushNamed(context, configRouteName)},
    );
  }
}
