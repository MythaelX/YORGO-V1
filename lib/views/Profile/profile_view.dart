import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/user_model.dart';
import 'package:yorgo/providers/user_provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return Container(
      alignment: Alignment.center,
      child: user != null
          ? Column(
              children: [
                Container(
                  height: 30,
                ),
                Container(height: 200, child: user.profile_image),
                Container(
                  height: 30,
                ),
                Text(
                  'Pseudo : ${user.username}',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Email : ${user.email}',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Prénom : ${user.firstname}',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nom : ${user.lastname}',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}
