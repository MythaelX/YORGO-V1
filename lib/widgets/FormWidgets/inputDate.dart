import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
    if (widget.initialValue != null && date == null) {
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
    final dateNow = DateTime.now();
    final initialDate;
    if (date != null) {
      initialDate = date;
    } else {
      initialDate = DateTime(dateNow.year - 18);
    }
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(dateNow.year - 100),
      lastDate: dateNow,
      builder: null,
    );

    if (newDate == null) return;

    setState(() => date = newDate);

    txtController.text = getText()!;
  }
}

class DateInput2 extends StatefulWidget {
  final String? texte;
  final DateTime? initialValue;
  final Icon? icon;
  final void Function(DateTime?)? onSaved;
  final String? Function(String?)? validator;
  const DateInput2({
    Key? key,
    this.texte,
    this.icon,
    this.onSaved,
    this.initialValue,
    this.validator,
  }) : super(key: key);

  @override
  State<DateInput2> createState() => _DateInput2State();
}

class _DateInput2State extends State<DateInput2> {
  DateTime? date;

  var txtController = TextEditingController();

  String? getText() {
    DateFormat f = new DateFormat('EE DD MMM H:mm', "FR");
    if (date == null) {
      return widget.texte;
    } else {
      return f.format(date!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null && date == null) {
      date = widget.initialValue;
      txtController.text = getText()!;
    }
    return TextFormField(
        controller: txtController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.texte,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          icon: widget.icon,
          suffixIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        onSaved: (value) => widget.onSaved!(date),
        validator: widget.validator!,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          DatePicker.showDateTimePicker(context,
              locale: LocaleType.fr,
              currentTime: DateTime.now(),
              minTime: DateTime.now(), onConfirm: (time) {
            date = time;
            txtController.text = getText()!;
          });
        });
  }
}
