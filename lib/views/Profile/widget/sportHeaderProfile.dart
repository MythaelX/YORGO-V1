import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/iconCustom/sport_icons.dart';
import 'package:yorgo/providers/sport_provider.dart';

class SportHeaderProfile extends StatelessWidget {
  final double width;
  final double height;
  final Map? userSports;
  const SportHeaderProfile({
    Key? key,
    required this.width,
    required this.height,
    this.userSports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sportToPrint;
    if (userSports != null) sportToPrint = userSports!.keys.take(3);
    var listsports = Provider.of<SportProvider>(context).sports;
    var mapSports;
    if (listsports != null) {
      mapSports = Map.fromIterable(listsports,
          key: (e) => e.id.toString(), value: (e) => e.icon);
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
      ),
      width: width / 3,
      height: height,
      child: (listsports != null && sportToPrint != null)
          ? getTextWidgets(sportToPrint.toList(), mapSports)
          : null,
    );
  }

  Widget getTextWidgets(List sportsToPrint, Map mapSports) {
    List<Widget> list = [];
    for (var i = 0; i < sportsToPrint.length; i++) {
      list.add(
        new Expanded(
          child: Icon(
            SportIcons.getIconByString(mapSports[sportsToPrint[i]]),
            size: height - 12,
            color: getColor(userSports![sportsToPrint[i]]),
          ),
        ),
      );
    }
    return new Row(children: list);
  }

  getColor(int level) {
    switch (level) {
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
