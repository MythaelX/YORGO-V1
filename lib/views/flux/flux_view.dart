import 'package:flutter/material.dart';
import 'package:yorgo/views/flux/flux_search_content.dart';
import 'package:yorgo/views/flux/widget/searchBarFlux.dart';

import '../../routes.dart';

class FluxView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarFlux(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.push(
              context,
              FadeRoute(page: FluxSearchContentView()),
            );
          },
        ),
        Expanded(child: Container()),
        Text(
          "Flux des publications",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          "Bientôt...",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
