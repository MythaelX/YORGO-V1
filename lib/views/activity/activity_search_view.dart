import 'package:flutter/material.dart';
import 'package:yorgo/widgets/navigation_drawer_widget.dart';

class ActivitySearchView extends StatelessWidget {
  static String routeName = '/activitysearch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mes Activités"),
        backgroundColor: Color.fromRGBO(73, 165, 216, 1),
      ),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: null,
      body: Container(
        alignment: Alignment.center,
        child: Text("vue vierge mes activités"),
      ),
    );
  }
}
