import 'package:flutter/material.dart';

class SearchBarActivity extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool autofocus;
  final double height;

  const SearchBarActivity({
    Key? key,
    this.onChanged,
    this.onTap,
    this.height = 50,
    this.hintText = "Rechercher...",
    this.autofocus = false,
  }) : super(key: key);

  @override
  State<SearchBarActivity> createState() => _SearchBarActivityState();
}

class _SearchBarActivityState extends State<SearchBarActivity> {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Material(
        elevation: 5,
        child: TextField(
          autofocus: widget.autofocus,
          textAlign: TextAlign.left,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            filled: true,
            hintText: 'Rechercher...',
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
            suffixIcon: (_controller.text != "")
                ? IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        _controller.text = "";
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                      size: 30,
                    ),
                  )
                : Icon(
                    Icons.search,
                    size: 30,
                  ),
          ),
          onChanged: (value) {
            setState(() {});
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
