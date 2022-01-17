import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/flux/widget/searchBarFlux.dart';
import 'package:yorgo/views/profile/profile_other_view.dart';
import 'package:yorgo/widgets/buttons/ProfileButton.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class FluxSearchContentView extends StatefulWidget {
  static String routeName = '/flux_search_content';

  @override
  State<FluxSearchContentView> createState() => _FluxSearchContentViewState();
}

class _FluxSearchContentViewState extends State<FluxSearchContentView> {
  List<Account> listAccount = [];
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        text: "Yorgo",
        elevation: false,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SearchBarFlux(
            onChanged: (value) async {
              if (value != "") {
                setState(() {
                  isloading = true;
                });
                var data =
                    await Provider.of<UserProvider>(context, listen: false)
                        .getUsersByQuery(value);
                if (data is List<Account>) {
                  listAccount = data;
                }
                setState(() {
                  isloading = false;
                });
              } else {
                setState(() {
                  listAccount = [];
                });
              }
            },
            autofocus: true,
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: (!isloading)
                ? SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            for (Account account in listAccount)
                              ProfileButton(
                                text: account.username.toString(),
                                text2: account.address_text,
                                onPressed: () {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .account = null;
                                  Navigator.pushNamed(
                                    context,
                                    ProfileOtherView.routeName,
                                    arguments: IdArguments(account.id!),
                                  );
                                },
                                imageUrl: account.profile_image,
                                icon: (account.is_friend!)
                                    ? Icons.person
                                    : Icons.person_off_rounded,
                                sizeIcon: 50,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 4),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        ].reversed.toList(),
      ),
    );
  }
}
