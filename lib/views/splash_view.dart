import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/home/home_views.dart';
import 'package:yorgo/views/home/profile_view.dart';

class SplashView extends StatelessWidget {
  static String routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    final bool isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;
    if (isLogggedin != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (isLogggedin == false) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        } else if (isLogggedin == true) {
          Navigator.pushReplacementNamed(context, ProfileView.routeName);
        }
      });
    }
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
}
