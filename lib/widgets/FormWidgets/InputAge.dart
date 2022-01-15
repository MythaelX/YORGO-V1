import 'package:flutter/material.dart';

class InputAge extends StatefulWidget {
  final String text;
  final void Function(int, int)? onSaved;

  const InputAge({
    Key? key,
    required this.text,
    this.onSaved,
  }) : super(key: key);

  @override
  State<InputAge> createState() => _InputAgeState();
}

class _InputAgeState extends State<InputAge> {
  var minValue = 18;
  var maxValue = 99;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await saveRangeAge();
        //changer la valeur du form
        if (minValue > maxValue) {
          setState(() {
            var minValue2 = minValue;
            minValue = maxValue;
            maxValue = minValue2;
          });
          if (widget.onSaved != null) {
            widget.onSaved!(minValue, maxValue);
          }
        }
      },
      child: Row(
        children: [
          Container(
            child: getTextAge(),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.arrow_forward_ios_sharp,
            ),
          )
        ],
      ),
    );
  }

  Future saveRangeAge() async {
    await showDialog(
      context: this.context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.only(top: 10),
        titlePadding: EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.fromLTRB(2.0, 15, 2.0, 6.0),
          color: Theme.of(context).primaryColor,
          child: Center(
              child: const Text(
            "Veuillez indiquer une tranche d'âge :",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          )),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Age minimum :",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Container(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    width: 35,
                    height: 30,
                    child: TextFormField(
                      initialValue: minValue.toString(),
                      onChanged: (value) {
                        if (value != "") {
                          minValue = int.parse(value);
                        } else {
                          minValue = 0;
                        }
                      },
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: "",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Age maximum :",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Container(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    width: 35,
                    height: 30,
                    child: TextFormField(
                      initialValue: maxValue.toString(),
                      onChanged: (value) {
                        if (value != "") {
                          maxValue = int.parse(value);
                        } else {
                          maxValue = 0;
                        }
                      },
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: "",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                    child: Text(
                  "Confirmer",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ))),
          ),
        ],
      ),
    );
  }

  getTextAge() {
    return RichText(
      text: TextSpan(
          text: 'Age entre ',
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: <TextSpan>[
            TextSpan(
              text: minValue.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            TextSpan(
              text: ' et ',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            TextSpan(
              text: maxValue.toString() + ' ans',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )
          ]),
    );
  }
}
