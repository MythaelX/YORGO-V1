import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:yorgo/models/profile_form_model.dart';

class RadiosButtons extends StatelessWidget {
  final ProfileForm? formTosave;

  const RadiosButtons({
    Key? key,
    this.formTosave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      selectedColor: Theme.of(context).primaryColor,
      unSelectedColor: Color.fromRGBO(255, 113, 104, 1),
      unSelectedBorderColor: Color.fromRGBO(255, 113, 104, 1),
      selectedBorderColor: Theme.of(context).primaryColor,
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.white,
        unSelectedColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.pinkAccent),
      ),
      buttonLables: [
        "Homme",
        "Femme",
        "Neutre",
      ],
      buttonValues: [
        0,
        1,
        2,
      ],
      radioButtonValue: (value) {
        print(value);
        formTosave!.gender = value as int?;
      },
      spacing: 0,
      defaultSelected: 0,
      horizontal: false,
      enableButtonWrap: false,
      width: 110,
      absoluteZeroSpacing: false,
      padding: 5,
      enableShape: true,
    );
  }
}
