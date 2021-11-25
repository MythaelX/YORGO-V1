import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/home/home_main_view.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/views/profile/profile_create_view.dart';

class SplashView extends StatelessWidget {
  static String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    getLogged(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        child: Text(
          'Yorgo',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> getUser(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).fetchCurrentUser();
    final User? user = Provider.of<UserProvider>(context, listen: false).user;
    if (user!.is_profile_complete == true) {
      Navigator.pushReplacementNamed(context, HomeMainView.routeName);
    } else {
      Navigator.pushReplacementNamed(context, ProfileCreateView.routeName);
    }
  }

  getLogged(BuildContext context) {
    final bool isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      if (isLogggedin == false) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
      } else {
        getUser(context);
      }
    });
  }
}
