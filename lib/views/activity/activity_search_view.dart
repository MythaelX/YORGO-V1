import 'package:flutter/material.dart';

class ActivitySearchView extends StatelessWidget {
  const ActivitySearchView({
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
          Text("Barre de Recherche"),
          Text("scroll infini avec les catégories")
        ],
      ),
    );
  }
}
