import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput1 extends StatefulWidget {
  final String? texte;
  final DateTime? initialValue;
  final Icon? icon;
  final void Function(String?)? onSaved;
  const DateInput1(
      {Key? key, this.texte, this.icon, this.onSaved, this.initialValue})
      : super(key: key);

  @override
  State<DateInput1> createState() => _DateInput1State();
}

class _DateInput1State extends State<DateInput1> {
  DateTime? date;
  final f = new DateFormat('yyyy / MM / dd');
  var txtController = TextEditingController();

  String? getText() {
    if (date == null) {
      return widget.texte;
    } else {
      return f.format(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      date = widget.initialValue;
      txtController.text = getText()!;
    }
    return TextFormField(
        controller: txtController,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          hintText: widget.texte,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          icon: widget.icon,
          suffixIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.8),
              offset: Offset(3, 1),
              blurRadius: 30,
            ),
          ],
        ),
        onSaved: widget.onSaved,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          pickDate(context);
        });
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(initialDate.year - 18),
      firstDate: DateTime(initialDate.year - 100),
      lastDate: initialDate,
      builder: null,
    );

    if (newDate == null) return;

    setState(() => date = newDate);

    txtController.text = getText()!;
  }
}
