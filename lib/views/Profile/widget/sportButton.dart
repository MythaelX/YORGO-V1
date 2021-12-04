import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SportButton extends StatefulWidget {
  final void Function(String, int)? onPressed;
  final String text;
  final double textFontsize;
  final EdgeInsetsGeometry padding;
  final IconData? icon;
  int? level = 0;

  SportButton({
    Key? key,
    this.onPressed,
    this.text = "",
    this.textFontsize = 25,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    this.icon = Icons.sports_soccer,
    this.level = 0,
  }) : super(key: key);

  @override
  State<SportButton> createState() => _SportButtonState();
}

class _SportButtonState extends State<SportButton> {
  Future<void> saveLevelSport() async {
    await showDialog(
      context: this.context,
      builder: (context) => SimpleDialog(
        titlePadding: EdgeInsets.symmetric(vertical: 8),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: Center(
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: " " + widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: Offset(3, 1),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.all(0),
        children: <Widget>[
          Column(
            children: <Widget>[
              buttonDialog(
                  text: "DÉBUTANT",
                  text2: "(moins de 6 mois de pratique)",
                  color: Color(0xFF00D3DA),
                  onPressed: () {
                    setState(() {
                      setLevelSport(level: 1);
                    });
                    Navigator.pop(context);
                  }),
              buttonDialog(
                  text: "INTERMÉDIAIRE",
                  text2: "(6 mois - 2 ans de pratique)",
                  color: Color(0xFFFFD563),
                  onPressed: () {
                    setState(() {
                      setLevelSport(level: 2);
                    });
                    Navigator.pop(context);
                  }),
              buttonDialog(
                  text: "CONFIRMÉ",
                  text2: "(plus de 2 ans de pratique)",
                  color: Color(0xffFF7168),
                  onPressed: () {
                    setState(() {
                      setLevelSport(level: 3);
                    });
                    Navigator.pop(context);
                  }),
              buttonDialog(
                  text: "Annuler / Supprimer",
                  lastButton: true,
                  onPressed: () {
                    setState(() {
                      setLevelSport(level: 0);
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        ],
      ),
    );
  }

  void setLevelSport({int level = 0}) {
    widget.level = level;
    if (widget.onPressed != null) {
      widget.onPressed!(widget.text, level);
    }
  }

  ElevatedButton buttonDialog({
    String text = "",
    String? text2,
    void Function()? onPressed,
    Color color = const Color(0xff7B7B7B),
    bool lastButton = false,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.zero,
        shape: (lastButton == true)
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0),
              )),
      ),
      onPressed: onPressed,
      child: (text2 != null)
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 25,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(3, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      text2,
                      style: TextStyle(
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(3, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(3, 2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      onPressed: saveLevelSport,
      child: Ink(
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: widget.padding,
          child: widget.icon == null
              ? getTextButton()
              : Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Icon(
                            widget.icon!,
                            color: Colors.white,
                            size: 29,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: getTextButton()),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  AutoSizeText getTextButton() {
    return AutoSizeText(
      widget.text,
      style: TextStyle(
        fontSize: widget.textFontsize,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(3, 2),
            blurRadius: 5,
          ),
        ],
      ),
      maxLines: 1,
    );
  }

  getColor() {
    switch (widget.level) {
      case 0:
        return Color(0xff7B7B7B);
      case 1:
        return Color(0xff00D3DA);
      case 2:
        return Color(0xffFFD563);
      case 3:
        return Color(0xffFF7168);
      default:
    }
    return Color(0xffffffff);
  }
}
