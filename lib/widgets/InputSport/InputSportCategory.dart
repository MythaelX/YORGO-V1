import 'package:flutter/material.dart';
import 'package:yorgo/iconCustom/sport_icons.dart';
import 'package:yorgo/models/form/profile_sport_form_model.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/widgets/InputSport/InputSportButton.dart';

class InputSportCategory extends StatelessWidget {
  final List<Sport> listSport;
  final String category;
  final Sport? sportSelected;
  final int? sportSelectedLevel;
  final void Function(Sport, int)? onPressed;
  const InputSportCategory(
      {Key? key,
      required this.listSport,
      required this.category,
      this.sportSelected,
      this.sportSelectedLevel,
      this.onPressed})
      : super(key: key);

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
            child: InputSportButton(
                text: item.name,
                icon: SportIcons.getIconByString(item.icon),
                level: (sportSelected == item) ? sportSelectedLevel : 0,
                onPressed: onPressed,
                sport: item),
          );
        }).toList()));
  }

  getLevel(String name, ProfileSportForm? form) {
    if (form!.sports.keys.contains(name)) {
      return form.sports[name];
    } else {
      return 0;
    }
  }
}
