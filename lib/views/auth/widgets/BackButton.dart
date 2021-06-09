import 'package:flutter/material.dart';
import 'package:yorgo/views/home/home_views.dart';

class BackButtonHome extends StatelessWidget {
  final Icon icon;
  const BackButtonHome({
    Key key,
    this.icon = const Icon(
      Icons.arrow_back,
      size: 30,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 20,
      child: Container(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: icon,
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, HomeView.routeName);
            }
          },
          color: Colors.white,
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
    );
  }
}
