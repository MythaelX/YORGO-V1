import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/iconCustom/sport_icons.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/providers/sport_provider.dart';
import 'package:yorgo/views/profile/widget/searchBar.dart';
import 'package:yorgo/widgets/Buttons/GradientElevatedButton.dart';
import 'package:yorgo/widgets/InputSport/InputSportCategory.dart';
import 'package:yorgo/widgets/colorTexts/textWhite.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import "package:collection/collection.dart";

class InputSportEditView extends StatefulWidget {
  static String routeName = '/input_sport_view';

  @override
  State<InputSportEditView> createState() => _InputSportEditViewState();
}

class _InputSportEditViewState extends State<InputSportEditView> {
  late List<Sport>? sports;
  String filter = "";
  Sport? sportSelected;
  int? sportSelectedLevel;

  @override
  Widget build(BuildContext context) {
    Map? groups = getSportBycategoryFilter(filter: filter);
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Nouvelle Activité",
        fontSize: 30,
      ),
      body: Stack(
        children: [
          getBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomScrollView(slivers: getContents(groups)),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.all(20),
                child: GradientElevatedButton(
                  text: "Confirmer",
                  colors: [Color(0xff65C5F8), Color(0xff2D93CC)],
                  onPressed: () async {
                    Navigator.pop(context, [sportSelected, sportSelectedLevel]);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getBackground() {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(207, 227, 239, 1),
                Color.fromRGBO(195, 213, 229, 1),
                Color.fromRGBO(173, 200, 221, 1),
                Color.fromRGBO(164, 192, 216, 1),
                Color.fromRGBO(126, 166, 198, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.2, 0.3, 0.4, 1]),
        ),
        alignment: Alignment.topCenter);
  }

  List<Widget> getContents(Map<dynamic, dynamic>? groups) {
    final Map? categorys = Provider.of<SportProvider>(context).categorys;
    if (groups != null && categorys != null) {
      List<Widget> contents = [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 10,
              ),
              Container(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar(
                    onChanged: (value) => {
                          setState(() {
                            filter = value;
                          })
                        }),
              )
            ],
          ),
        )
      ];
      if (groups.isNotEmpty) {
        groups.forEach((key, value) {
          contents.add(SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 20,
            ),
            TextWhiteIcon(
              text: categorys[key].name,
              icon: SportIcons.getIconByString(categorys[key].icon),
            )
          ])));
          contents.add(InputSportCategory(
              category: key.toString(),
              listSport: value,
              onPressed: (sport, value) {
                this.sportSelected = sport;
                this.sportSelectedLevel = value;
                setState(() {});
              },
              sportSelected: sportSelected,
              sportSelectedLevel: sportSelectedLevel));
        });
      }
      contents.add(SliverList(
          delegate: SliverChildListDelegate([
        Container(
          height: 100,
        )
      ])));
      return contents;
    }
    return [];
  }

  Map? getSportBycategory() {
    sports = Provider.of<SportProvider>(context).sports;

    if (sports != null) {
      final groups = groupBy(sports!, (Sport e) {
        return e.category;
      });
      return groups;
    }
    return null;
  }

  Map? getSportBycategoryFilter({required String filter}) {
    sports = Provider.of<SportProvider>(context).sports;
    if (sports != null) {
      final groups = groupBy(
          sports!
              .where((Sport sport) =>
                  sport.name.toLowerCase().contains(filter.toLowerCase()))
              .toList(), (Sport e) {
        return e.category;
      });
      return groups;
    }
    return null;
  }
}
