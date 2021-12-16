import 'package:flutter/material.dart';

class FriendMapView extends StatelessWidget {
  const FriendMapView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [Text("FriendMapView"), Text("Carte des amis")],
      ),
    );
  }
}
