import 'package:flutter/material.dart';

class TextInput1 extends StatelessWidget {
  final String? texte;
  final String? initialValue;
  final Icon? icon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const TextInput1({
    Key? key,
    this.texte,
    this.icon,
    this.onSaved,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
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
      onSaved: onSaved,
      validator: validator,
    );
  }
}

class TextInput2 extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;
  const TextInput2({Key? key, this.onSaved, this.validator, this.initialValue})
      : super(key: key);

  @override
  State<TextInput2> createState() => _TextInput2State();
}

class _TextInput2State extends State<TextInput2> {
  int maxLength = 500;
  int textLength = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      maxLength = maxLength - widget.initialValue!.length;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Stack(
        children: [
          TextFormField(
            initialValue: widget.initialValue,
            validator: widget.validator,
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
                  borderRadius: BorderRadius.circular(5)),
              errorStyle: TextStyle(
                color: Colors.red[900],
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(1),
                    offset: Offset(2, 1),
                    blurRadius: 4,
                  ),
                ],
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
            keyboardType: TextInputType.multiline,
            scrollPadding: EdgeInsets.all(100),
            maxLines: 4,
            maxLength: maxLength,
            onChanged: (value) {
              setState(() {
                textLength = value.length;
              });
            },
            onSaved: widget.onSaved,
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

class TextInput3 extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const TextInput3({
    Key? key,
    this.text,
    this.icon,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        errorMaxLines: 3,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        hintText: text,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        errorStyle: TextStyle(
          color: Colors.red[900],
          shadows: [
            Shadow(
              color: Colors.white.withOpacity(1),
              offset: Offset(2, 1),
              blurRadius: 4,
            ),
          ],
          fontWeight: FontWeight.w700,
          fontSize: 14.0,
        ),
      ),
      validator: validator,
      style: TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(3, 2),
            blurRadius: 5,
          ),
        ],
      ),
      onSaved: onSaved,
    );
  }
}

class TextInputPassword extends StatelessWidget {
  final String? texte;
  final void Function(String?)? onSaved;
  final void Function()? onPressed;
  final bool? hidePassword;
  final String? Function(String?)? validator;

  const TextInputPassword({
    Key? key,
    this.texte,
    this.onSaved,
    this.onPressed,
    this.hidePassword,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidePassword == true ? true : false,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        hintText: texte,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: hidePassword == true
              ? Icon(
                  Icons.visibility,
                  color: Colors.white,
                )
              : Icon(
                  Icons.visibility_off,
                  color: Colors.white,
                ),
          onPressed: onPressed,
        ),
        errorStyle: TextStyle(
          color: Colors.red[900],
          shadows: [
            Shadow(
              color: Colors.white.withOpacity(1),
              offset: Offset(2, 1),
              blurRadius: 4,
            ),
          ],
          fontWeight: FontWeight.w700,
          fontSize: 14.0,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(3, 2),
            blurRadius: 5,
          ),
        ],
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
