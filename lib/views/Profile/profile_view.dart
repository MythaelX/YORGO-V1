import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/models/data/user_model.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/profile/widget/headerProfile.dart';
import 'package:yorgo/views/profile/widget/infosProfile.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    final List<Friend>? listFriends =
        Provider.of<UserProvider>(context).listFriend;
    int? numberOfFriends;
    if (listFriends != null) {
      numberOfFriends = listFriends.length;
    }
    return Container(
      color: Colors.white,
      child: user != null
          ? ListView(
              children: [
                headerProfile(user, numberOfFriends: numberOfFriends),
                Container(
                  child: (user.description != null && user.description != "")
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            user.description.toString(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                        )
                      : Container(
                          height: 10,
                        ),
                ),
                tabBarMenu(length: 2, listTab: [
                  "Infos",
                  "Flux",
                ], listContentTab: [
                  InfosProfile(user: user),
                  Container(
                    child: Center(
                      child: Text('Display Flux',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]),
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}
