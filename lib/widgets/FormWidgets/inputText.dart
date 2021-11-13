import 'package:flutter/material.dart';

class TextInput1 extends StatelessWidget {
  final String? texte;
  final Icon? icon;
  const TextInput1({
    Key? key,
    this.texte,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(73, 165, 216, 1), width: 2.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        hintText: this.texte,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        icon: icon,
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(3, 1),
            blurRadius: 30,
          ),
        ],
      ),
      onSaved: (newValue) {},
    );
  }
}

class TextInput2 extends StatefulWidget {
  const TextInput2({
    Key? key,
  }) : super(key: key);

  @override
  State<TextInput2> createState() => _TextInput2State();
}

class _TextInput2State extends State<TextInput2> {
  int maxLength = 500;
  int textLength = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Stack(
        children: [
          TextField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                filled: true,
                hintText: 'A votre sujet',
                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5))),
            keyboardType: TextInputType.multiline,
            scrollPadding: EdgeInsets.all(100),
            maxLines: 4,
            maxLength: maxLength,
            onChanged: (value) {
              setState(() {
                textLength = value.length;
              });
            },
          ),
          Positioned(
              right: 5,
              bottom: 2,
              child: Text('${(maxLength - textLength).toString()}',
                  style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
