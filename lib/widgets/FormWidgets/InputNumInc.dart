import 'package:flutter/material.dart';

class InputNumInc extends StatefulWidget {
  final String? texte;
  final Icon? icon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;

  const InputNumInc({
    Key? key,
    this.texte,
    this.icon,
    this.onSaved,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  State<InputNumInc> createState() => _InputNumIncState();
}

class _InputNumIncState extends State<InputNumInc> {
  TextEditingController controller = new TextEditingController();
  int cptValue = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 6,
            child: Text(
              this.widget.texte.toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )),
        Expanded(child: Container()),
        IconButton(
            padding: EdgeInsets.all(2),
            onPressed: () {
              if (cptValue == 0) {
                controller.text = "";
              } else if (cptValue == 1) {
                controller.text = "";
              } else {
                cptValue--;
                controller.text = cptValue.toString();
              }
              FocusScope.of(context).unfocus();
              setState(() {});
            },
            icon: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ))),
        Flexible(
          child: Container(
            width: 35,
            height: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value != "") {
                  cptValue = int.parse(controller.text);
                } else {
                  cptValue = 0;
                }
              },
              textAlign: TextAlign.center,
              controller: controller,
              initialValue: widget.initialValue,
              maxLength: 2,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "∞",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                icon: widget.icon,
                errorStyle: TextStyle(
                  color: Colors.red[900],
                  shadows: [
                    Shadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: Offset(2, 1),
                      blurRadius: 10,
                    ),
                  ],
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              onSaved: this.widget.onSaved,
              validator: widget.validator,
            ),
          ),
        ),
        IconButton(
            padding: EdgeInsets.all(2),
            onPressed: () {
              if (cptValue == 99) {
                controller.text = "99";
              } else {
                cptValue++;
                controller.text = cptValue.toString();
              }
              FocusScope.of(context).unfocus();
              setState(() {});
            },
            icon: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ))),
      ],
    );
  }
}
