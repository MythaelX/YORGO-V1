import 'package:flutter/material.dart';
import 'package:yorgo/models/data/sport_model.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/widgets/InputSport/InputSportView.dart';

class SportInput extends StatefulWidget {
  final String? text;
  final Icon? icon;
  final void Function(int, int)? onSaved;
  final String? Function(String?)? validator;

  const SportInput({
    Key? key,
    this.text,
    this.icon,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  State<SportInput> createState() => _SportInputState();
}

class _SportInputState extends State<SportInput> {
  var txtController = TextEditingController();
  Sport? sport;
  int? sportLevel;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: txtController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.text,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        validator: widget.validator,
        onSaved: (valeur) {
          if (this.sport != null &&
              this.sportLevel != null &&
              widget.onSaved != null) {
            widget.onSaved!(
              this.sport!.id,
              this.sportLevel!,
            );
          }
        },
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          var value = await Navigator.push(
              context, FadeRoute(page: InputSportEditView()));
          if (value != null) {
            sport = value[0];
            sportLevel = value[1];
            txtController.text =
                sport!.name + " : " + getLevelSport(sportLevel);
          } else {
            txtController.text = "";
          }
        });
  }

  getLevelSport(value) {
    switch (value) {
      case 1:
        return "Débutant";
      case 2:
        return "Intermédiaire";
      case 3:
        return "Confirmé";
      default:
        return "";
    }
  }
}
