import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/friend_model.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/views/friend/widget/FriendButton.dart';
import 'package:yorgo/views/profile/widget/searchBar.dart';

class FriendSearchView extends StatefulWidget {
  const FriendSearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendSearchView> createState() => _FriendSearchViewState();
}

class _FriendSearchViewState extends State<FriendSearchView> {
  String filter = "";
  @override
  Widget build(
    BuildContext context,
  ) {
    final List<Friend>? listFriend =
        Provider.of<UserProvider>(context).listFriend;
    List<Friend>? listFriendFilter =
        getFriendsByUsernameFilter(filter: filter, listFriend: listFriend);
    return Container(
      child: (listFriend != null)
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          getNumberFriend(listFriend.length),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SearchBar2(
                          onChanged: (value) => {
                            setState(() {
                              filter = value;
                            })
                          },
                        ),
                      ),
                      for (Friend item in listFriendFilter)
                        FriendButton(friend: item)
                      // ProfileButton(
                      //   text: item.username,
                      //   text2: item.address_text,
                      //   imageUrl: item.profile_image,
                      //   icon: Icons.more_horiz,
                      //   onPressed: () => () {},
                      // )
                    ],
                  ),
                ),
              ),
            )
          : Container(child: Center(child: CircularProgressIndicator())),
    );
  }

  String getNumberFriend(int length) {
    if (length > 1) {
      return length.toString() + " Amis";
    } else {
      return length.toString() + " Ami";
    }
  }

  List<Friend> getFriendsByUsernameFilter(
      {required String filter, required List<Friend>? listFriend}) {
    List<Friend> listFriendFilter = [];
    if (listFriend != null) {
      for (Friend friend in listFriend) {
        if (friend.username.toLowerCase().contains(filter.toLowerCase())) {
          listFriendFilter.add(friend);
        }
      }
    }
    return listFriendFilter;
  }
}
