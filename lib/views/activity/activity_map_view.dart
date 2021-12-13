import 'package:flutter/material.dart';

class ActivityMapView extends StatelessWidget {
  const ActivityMapView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Carte avec les activités dans le coin"),
        ],
      ),
    );
  }
}
