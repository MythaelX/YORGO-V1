import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/user_model.dart';
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

  getUser(BuildContext context, User? user) {
    //on attend init de User
    if (user != null) {
      if (user.is_profile_complete == true) {
        Navigator.pushReplacementNamed(context, HomeMainView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, ProfileCreateView.routeName);
      }
      // } else {
      //   // Provider.of<UserProvider>(context, listen: false)
      //   //     .update(Provider.of<AuthProvider>(context, listen: false));
      // }
    }
  }

  getLogged(BuildContext context) {
    //on get user et les token
    final bool? isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;
    final User? user = Provider.of<UserProvider>(context).user;
    //on attend init de auth
    if (isLogggedin != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        if (isLogggedin == false) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        } else {
          getUser(context, user);
        }
      });
    }
  }
}
