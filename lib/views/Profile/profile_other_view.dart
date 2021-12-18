import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/models/data/friend_model.dart';

import 'package:yorgo/providers/user_provider.dart';

import 'package:yorgo/views/profile/widget/headerProfileOther.dart';
import 'package:yorgo/views/profile/widget/infosProfile.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';
import 'package:yorgo/widgets/menus/tabBarMenu.dart';

class ProfileOtherView extends StatefulWidget {
  static String routeName = '/profile_other';
  final int id;

  const ProfileOtherView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProfileOtherView> createState() => _ProfileOtherViewState();
}

class _ProfileOtherViewState extends State<ProfileOtherView> {
  @override
  Widget build(BuildContext context) {
    final Account? account = Provider.of<UserProvider>(context).account;
    final List<Friend>? listFriends = [];
    int? numberOfFriends;
    if (listFriends != null) {
      numberOfFriends = listFriends.length;
    }
    if (account == null) {
      Provider.of<UserProvider>(context).getUserInformation(widget.id);
    }

    return Scaffold(
      appBar: HeaderAppBar(
        texte: "Yorgo",
      ),
      body: Container(
        color: Colors.white,
        child: account != null
            ? ListView(
                children: [
                  headerProfileOther(account, numberOfFriends: numberOfFriends),
                  Container(
                    child: (account.description != null &&
                            account.description != "")
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              account.description.toString(),
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
                    InfosProfileOther(account: account),
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
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
