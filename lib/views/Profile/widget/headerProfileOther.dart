import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:yorgo/models/data/account_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:yorgo/providers/user_provider.dart';
import 'package:yorgo/routes.dart';
import 'package:yorgo/views/message/message_sportsmen_room_view.dart';
import 'package:yorgo/views/profile/widget/backgroundProfile.dart';
import 'package:yorgo/views/profile/widget/imageProfile.dart';
import 'package:yorgo/views/profile/widget/sportHeaderProfile.dart';
import 'package:yorgo/widgets/colorTexts/textBlue.dart';
import 'package:yorgo/widgets/progressor/dialog_progressor.dart';

class headerProfileOther extends StatefulWidget {
  final int? numberOfFriends;
  final Account account;
  final void Function()? friendFunction;
  final void Function()? activityFunction;
  final void Function()? followFunction;
  const headerProfileOther(
    this.account, {
    Key? key,
    this.numberOfFriends,
    this.friendFunction,
    this.activityFunction,
    this.followFunction,
  }) : super(key: key);

  @override
  State<headerProfileOther> createState() => _headerProfileOtherState();
}

class _headerProfileOtherState extends State<headerProfileOther> {
  Future<void> optionFriend() async {
    await showDialog(
      context: this.context,
      builder: (context) => SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    buttonDialog(
                        text: "Accepter l'inviation",
                        color: Color(0xff6ECEA4),
                        textcolor: Colors.white,
                        iconData: Icons.check,
                        onPressed: () async {
                          DialogBuilder(context).showLoadingIndicator(
                              'votre demande est en cours.');
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .friendRequestAccept(
                                  widget.account.pending_friend_request_id!);
                          setState(() {
                            Provider.of<UserProvider>(context, listen: false)
                                .account!
                                .pending_friend_request_id = null;
                            Provider.of<UserProvider>(context, listen: false)
                                .account!
                                .request_sent = -1;
                            Provider.of<UserProvider>(context, listen: false)
                                .account!
                                .is_friend = true;
                          });
                          DialogBuilder(context).hideOpenDialog();
                          Navigator.pop(context);
                        }),
                    Container(
                      height: 10,
                    ),
                    buttonDialog(
                        text: "Refuser l'invitations",
                        color: Color(0xffFF7168),
                        iconData: Icons.cancel,
                        textcolor: Colors.white,
                        onPressed: () async {
                          DialogBuilder(context).showLoadingIndicator(
                              'votre demande est en cours.');

                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .friendRequestDecline(
                                  widget.account.pending_friend_request_id!);
                          setState(() {
                            Provider.of<UserProvider>(context, listen: false)
                                .account!
                                .pending_friend_request_id = null;
                            Provider.of<UserProvider>(context, listen: false)
                                .account!
                                .request_sent = -1;
                          });
                          DialogBuilder(context).hideOpenDialog();
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              Positioned(
                top: -8,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel_sharp,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> validateDemandRemoveFriend() async {
    await showDialog(
      context: this.context,
      builder: (context) => SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    buttonDialog(
                        text: "Supprimer des amis",
                        color: Color(0xffFF7168),
                        textcolor: Colors.white,
                        iconData: Icons.person_off_rounded,
                        onPressed: () async {
                          DialogBuilder(context).showLoadingIndicator(
                              'votre demande est en cours.');
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .friendRemove(widget.account.id!);
                          setState(() {
                            Provider.of<UserProvider>(context, listen: false)
                                .account!
                                .is_friend = false;
                          });
                          DialogBuilder(context).hideOpenDialog();
                          Navigator.pop(context);
                        }),
                    Container(
                      height: 10,
                    ),
                    buttonDialog(
                        text: "Annuler ma demande",
                        iconData: Icons.cancel,
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              Positioned(
                top: -8,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel_sharp,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton buttonDialog(
      {String text = "",
      Color textcolor = const Color.fromRGBO(73, 165, 216, 1),
      void Function()? onPressed,
      Color color = Colors.white,
      IconData? iconData}) {
    var icon = Container();
    var prefix = Container();
    if (iconData != null) {
      icon = Container(
          width: 35,
          alignment: Alignment.centerRight,
          child: Icon(
            iconData,
            color: textcolor,
            size: 30,
          ));
      prefix = Container(
        width: 30,
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.blue,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Row(
          children: [
            prefix,
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  height: 25,
                  child: AutoSizeText(
                    text,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: textcolor,
                    ),
                  ),
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              BackgroundProfile(
                height: 110,
                image: null,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: (width / 2.2), top: 15, right: 10),
                child: TextBlue(
                  text: ' ${widget.account.username!.toUpperCase()}',
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ),
              Container(
                height: 15,
              ),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextButton(
                      onPressed: widget.activityFunction,
                      child: Align(
                        child: TextBlue(
                          text: "X\n Activités",
                          textFontsize: 20,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextButton(
                      onPressed: widget.friendFunction,
                      child: Align(
                          child: TextBlue(
                        text: widget.numberOfFriends.toString() + "\n Amis",
                        textFontsize: 20,
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: TextButton(
                        onPressed: widget.followFunction,
                        child: Align(
                          child: TextBlue(
                            text: "0\n Abonnés",
                            textFontsize: 20,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "follow",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: getAccountFriendButton(widget.account),
                    ),
                  ),
                  getAccountMessage(widget.account),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: SportHeaderProfile(
              width: width,
              height: 50,
              userSports: widget.account.sports,
            ),
          ),
          Positioned(
            top: 10,
            left: 30,
            child: ImageProfile(size: 160, image: widget.account.profile_image),
          ),
        ],
      ),
    );
  }

  getAccountFriendButton(Account? account) {
    // NO_REQUEST_SENT = -1
    // THEM_SENT_TO_YOU = 0
    // YOU_SENT_TO_THEM = 1
    switch (account!.request_sent) {
      case -1:
        if (account.is_friend!) {
          return ElevatedButton(
            onPressed: validateDemandRemoveFriend,
            child: Icon(
              Icons.person_remove_alt_1,
              size: 30,
              color: Colors.white,
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () async {
              final error =
                  await Provider.of<UserProvider>(context, listen: false)
                      .friendSendDemand(widget.account.id!);
              if (error == null) {
                setState(() {
                  Provider.of<UserProvider>(context, listen: false)
                      .account!
                      .request_sent = 1;
                });
              } else {
                final snackBar = SnackBar(
                  content: const Text('Erreur lors de la demande au serveur.'),
                );
                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Icon(
              Icons.person_add_alt_1,
              size: 30,
              color: Colors.white,
            ),
          );
        }
      case 0:
        return ElevatedButton(
          onPressed: optionFriend,
          child: Text(
            "Ajouter ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        );
      case 1:
        return ElevatedButton(
          onPressed: () async {
            final error;
            if (widget.account.pending_friend_request_id != null) {
              error = await Provider.of<UserProvider>(context, listen: false)
                  .friendRequestDecline(
                      widget.account.pending_friend_request_id!);
            } else {
              error = "error";
            }
            if (error == null) {
              setState(() {
                Provider.of<UserProvider>(context, listen: false)
                    .account!
                    .request_sent = -1;
              });
            } else {
              final snackBar = SnackBar(
                content: const Text('Erreur lors de la demande au serveur.'),
              );
              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Icon(
            Icons.person_add_disabled,
            size: 30,
            color: Colors.white,
          ),
        );
      default:
        return ElevatedButton(
          onPressed: () {},
          child: Text("???"),
        );
    }
  }

  getAccountMessage(Account? account) {
    if (account!.is_friend!) {
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              var tokenAccess =
                  Provider.of<AuthProvider>(context, listen: false).tokenAccess;
              DialogBuilder(context)
                  .showLoadingIndicator('Chargement en cours');
              var room_id = await Provider.of<NotificationProvider>(context,
                      listen: false)
                  .getOrCreateRoomFriend(widget.account);
              DialogBuilder(context).hideOpenDialog();
              if (room_id != null) {
                Navigator.pushNamed(
                  context,
                  MessageSportsmenRoom.routeName,
                  arguments: PrivateRoomArguments(
                      IOWebSocketChannel.connect(
                          "ws://yorgoapi.herokuapp.com/api/chat/" +
                              room_id.toString() +
                              "/?token=" +
                              tokenAccess!),
                      widget.account,
                      room_id),
                );
              }
            },
            child: Text(
              "Ecrire",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
