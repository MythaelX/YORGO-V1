import 'package:flutter/material.dart';

//Page Import :
import 'views/home/home_views.dart';
import 'views/auth/signin_view.dart';
import 'views/auth/signup_view.dart';
import 'views/home/profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YORGO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      onGenerateRoute: (settings) {
        if (settings.name == SigninView.routeName) {
          return MaterialPageRoute(builder: (_) => SigninView());
        } else if (settings.name == SignupView.routeName) {
          return MaterialPageRoute(builder: (_) => SignupView());
        } else if (settings.name == ProfileView.routeName) {
          return MaterialPageRoute(builder: (_) => ProfileView());
        } else {
          return null;
        }
      },
    );
  }
}
