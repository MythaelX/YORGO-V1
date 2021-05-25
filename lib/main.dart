import 'package:flutter/material.dart';

import 'views/home/home_views.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YORGO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
