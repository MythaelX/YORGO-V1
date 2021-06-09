import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/not_found_view.dart';

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
  final AuthProvider authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
      ],
      child: MaterialApp(
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
          } else if (settings.name == HomeView.routeName) {
            return MaterialPageRoute(builder: (_) => HomeView());
          } else {
            return MaterialPageRoute(builder: (_) => NotFoundView());
          }
        },
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (_) => NotFoundView()),
      ),
    );
  }
}
