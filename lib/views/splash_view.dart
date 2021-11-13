import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/views/flux/flux_view.dart';
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

  getLogged(BuildContext context) {
    final bool isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (isLogggedin == false) {
        Navigator.pushReplacementNamed(context, ProfileCreateView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, FluxView.routeName);
      }
    });
  }
}
