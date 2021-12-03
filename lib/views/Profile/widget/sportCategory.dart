import 'package:flutter/material.dart';
import 'package:yorgo/iconCustom/sport_icons.dart';
import 'package:yorgo/models/profile_sport_form_model.dart';
import 'package:yorgo/models/sport_model.dart';
import 'package:yorgo/views/profile/widget/sportButton.dart';

class SportCategory extends StatelessWidget {
  final List<Sport> listSport;
  final String category;
  final ProfileSportForm? form;

  const SportCategory({
    Key? key,
    required this.listSport,
    required this.category,
    this.form,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: 3.4,
        ),
        delegate: SliverChildListDelegate(listSport.map((Sport item) {
          return Container(
            child: SportButton(
              text: item.name,
              icon: SportIcons.getIconByString(item.icon),
              level: getLevel(item.name, form),
              onPressed: (form != null)
                  ? (String sportName, int level) {
                      if (level == 0 && form!.sports.containsKey(sportName)) {
                        form!.sports.remove(sportName);
                      } else {
                        form!.sports[sportName] = level;
                      }
                    }
                  : null,
            ),
          );
        }).toList()));
  }

  getLevel(String name, ProfileSportForm? form) {
    if (form!.sports.keys.contains(name)) {
      return form!.sports[name];
    } else {
      return 0;
    }
  }
}
