import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/activity_provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:yorgo/providers/sport_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/not_found_view.dart';
import 'package:yorgo/views/splash_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthProvider authProvider = AuthProvider();

  @override
  initState() {
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
        ChangeNotifierProxyProvider<AuthProvider, NotificationProvider>(
            create: (_) => NotificationProvider(),
            update: (_, authProvider, oldNotificationProvider) {
              oldNotificationProvider!.update(authProvider);
              return oldNotificationProvider;
            }),
        ChangeNotifierProxyProvider<AuthProvider, SportProvider>(
            create: (_) => SportProvider(),
            update: (_, authProvider, oldSportProvider) {
              oldSportProvider!.update(authProvider);
              return oldSportProvider;
            }),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
            create: (_) => UserProvider(),
            update: (_, authProvider, oldUserProvider) {
              oldUserProvider!.update(authProvider);
              return oldUserProvider;
            }),
        ChangeNotifierProxyProvider<AuthProvider, ActivityProvider>(
            create: (_) => ActivityProvider(),
            update: (_, authProvider, oldActivityProvider) {
              oldActivityProvider!.update(authProvider);
              return oldActivityProvider;
            }),
      ],
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('en'), const Locale('fr')],
        theme: new ThemeData(
          brightness: Brightness.light,
          primarySwatch: MaterialColor(0xFF49A5D8, <int, Color>{
            50: Color.fromRGBO(73, 165, 216, .1),
            100: Color.fromRGBO(73, 165, 216, .2),
            200: Color.fromRGBO(73, 165, 216, .3),
            300: Color.fromRGBO(73, 165, 216, .4),
            400: Color.fromRGBO(73, 165, 216, .5),
            500: Color.fromRGBO(73, 165, 216, .6),
            600: Color.fromRGBO(73, 165, 216, .7),
            700: Color.fromRGBO(73, 165, 216, .8),
            800: Color.fromRGBO(73, 165, 216, .9),
            900: Color.fromRGBO(73, 165, 216, 1),
          }),
          primaryColor: Color.fromRGBO(73, 165, 216, 1),
          secondaryHeaderColor: Colors.pink,
          splashColor: Colors.black26,
        ),
        debugShowCheckedModeBanner: false,
        title: 'YORGO',
        home: SplashView(),
        onGenerateRoute: routes,
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (_) => NotFoundView()),
      ),
    );
  }
}
