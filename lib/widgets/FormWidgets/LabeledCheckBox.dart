import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              label,
              style: TextStyle(fontSize: 18),
            )),
            Transform.scale(
              scale: 1.5,
              child: Switch(
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
