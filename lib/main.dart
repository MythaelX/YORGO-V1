import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/not_found_view.dart';
import 'package:yorgo/views/splash_view.dart';

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
  void initState() {
    authProvider.initAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
            create: (_) => UserProvider(),
            update: (_, authProvider, oldUserProvider) {
              oldUserProvider.update(authProvider);
              return oldUserProvider;
            }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YORGO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashView(),
        onGenerateRoute: routes,
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (_) => NotFoundView()),
      ),
    );
  }
}
