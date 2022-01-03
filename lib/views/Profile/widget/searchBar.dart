import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String) onChanged;
  final String hintText;

  SearchBar({
    Key? key,
    required this.onChanged,
    this.hintText = "Rechercher",
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextField(
      textAlign: TextAlign.left,
      controller: _controller,
      onChanged: (value) {
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(90, 0, 0, 0),
        isDense: true,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        enabledBorder: const OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: const BorderSide(color: Colors.grey, width: 0),
        ),
        labelStyle: new TextStyle(color: Colors.green),
        prefixIconConstraints: BoxConstraints(minWidth: 65, minHeight: 48),
        prefixIcon: Container(
          padding: const EdgeInsetsDirectional.only(start: 0.0, end: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        suffixIcon: (_controller.text != "")
            ? IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  widget.onChanged("");
                  _controller.text = "";
                },
                icon: Icon(Icons.clear),
              )
            : null,
      ),
    );
  }
}

class SearchBar2 extends StatefulWidget {
  final void Function(String) onChanged;
  final String hintText;
  SearchBar2({
    Key? key,
    required this.onChanged,
    this.hintText = "Rechercher",
  }) : super(key: key);

  @override
  State<SearchBar2> createState() => _SearchBarState2();
}

class _SearchBarState2 extends State<SearchBar2> {
  var _controller = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextField(
      textAlign: TextAlign.left,
      controller: _controller,
      onChanged: (value) {
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(90, 0, 0, 0),
        isDense: true,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            gapPadding: 50,
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.7), width: 2),
        ),
        labelStyle: new TextStyle(color: Colors.green),
        prefixIconConstraints: BoxConstraints(minWidth: 65, minHeight: 48),
        prefixIcon: Container(
          padding: const EdgeInsetsDirectional.only(start: 0.0, end: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        suffixIcon: (_controller.text != "")
            ? IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  widget.onChanged("");
                  _controller.text = "";
                },
                icon: Icon(Icons.clear),
              )
            : null,
      ),
    );
  }
}
