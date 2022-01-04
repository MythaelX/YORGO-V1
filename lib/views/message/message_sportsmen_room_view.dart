import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yorgo/models/data/message_model.dart';
import 'package:yorgo/views/message/widget/MessageContent.dart';
import 'package:yorgo/widgets/header_app_bar_widget.dart';

class MessageSportsmenRoom extends StatefulWidget {
  static String routeName = '/message_sportsmen_room';
  final dynamic friend;
  final WebSocketChannel channel;
  final int room_id;

  const MessageSportsmenRoom({
    Key? key,
    required this.friend,
    required this.channel,
    required this.room_id,
  }) : super(key: key);

  @override
  _MessageSportsmenRoomState createState() => _MessageSportsmenRoomState();
}

class _MessageSportsmenRoomState extends State<MessageSportsmenRoom> {
  List<Message> messageList = [];
  int StreamCpt = 0;
  int newPageNumber = 1;
  bool loading = true;
  bool loadingMessage = false;
  bool initChat = false;
  bool focus = false;
  bool allMessageLoad = false;
  bool popCan = true;
  ScrollController _scrollcontroller = ScrollController();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollcontroller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    popCan = false;
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollcontroller.position.extentAfter == 0 &&
        loadingMessage != true &&
        allMessageLoad != true) {
      widget.channel.sink.add(json.encode({
        'pk': widget.room_id,
        'page_number': newPageNumber,
        'action': "get_room_chat_messages",
        'request_id': DateTime.now().toString()
      }));

      //items.addAll(List.generate(42, (index) => 'Inserted $index'));

    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(json.encode({
        'message': _controller.text,
        'action': "send",
        'request_id': DateTime.now().toString(),
      }));
    }

    setState(() {
      FocusScope.of(context).unfocus();
      _controller.text = "";
      focus = false;
    });
  }

  void messageProcess(data) {
    var valueDecode = json.decode(data);

    if (valueDecode["join"] != null) {
      if (valueDecode["join"] != widget.room_id.toString()) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          loading = false;
        });
      }
      return;
    }

    if (valueDecode["display_progress_bar"] != null) {
      if (valueDecode["display_progress_bar"] == true) {
        setState(() {
          loadingMessage = true;
        });
      }

      if (valueDecode["display_progress_bar"] == false) {
        setState(() {
          loadingMessage = false;
        });
      }
      return;
    }

    if (valueDecode["messages_payload"] == "messages_payload") {
      if (valueDecode["messages"] != "None") {
        List ListeMessage = valueDecode["messages"];
        var index = 0;
        for (var message in ListeMessage) {
          var isMe = false;
          var showTime = false;
          var timeMessage = DateTime.parse(message["timestamp"]);
          if (message['user_id'].toString() ==
              valueDecode["user_id"].toString()) {
            isMe = true;
          }
          if (ListeMessage.length == 1 || index == (ListeMessage.length - 1)) {
            showTime = true;
          } else {
            //on regarde si on a une diff de 1h avec le dernier message envoyé (si oui on affiche le temps)
            var timeMessageBefore =
                DateTime.parse(ListeMessage.elementAt(index + 1)["timestamp"]);
            if (timeMessage
                .add(Duration(hours: -1))
                .isAfter(timeMessageBefore)) {
              showTime = true;
            }
          }

          newPageNumber = valueDecode['new_page_number'];
          messageList.add(Message.fromMap({
            "message": message["message"],
            "natural_timestamp": message["natural_timestamp"],
            "profile_image": message["profile_image"],
            "timestamp": timeMessage,
            "showTime": showTime,
            "isMe": isMe,
          }));
          index++;
        }
        return;
        // messageList = List.from(messageList.reversed);
      } else {
        allMessageLoad = true;
      }

      if (valueDecode["error"] == "ROOM_ACCESS_DENIED") {
        Navigator.of(context).pop();
        return;
      }
    }

    // Type 0 normal message, Type 1 connected user, Type 2 leave user
    if (valueDecode["msg_type"] == 0) {
      setState(() {
        var isMe = false;
        var showTime = false;
        var timeMessage = DateTime.parse(valueDecode["timestamp"]);
        if (valueDecode['user_id'].toString() != widget.friend.id.toString()) {
          isMe = true;
        }

        if (timeMessage.add(Duration(hours: -1)).isAfter(
              messageList.elementAt(0).timestamp,
            )) {
          //on regarde si on a une diff de 1h avec le dernier message envoyé (si oui on affiche le temps)
          showTime = true;
        }
        messageList.insert(
            0,
            Message.fromMap({
              "message": valueDecode["message"],
              "natural_timestamp": valueDecode["natural_timestamp"],
              "profile_image": valueDecode["profile_image"],
              "timestamp": timeMessage,
              "showTime": showTime,
              "isMe": isMe,
            }));
        //}
      });
      return;
    }

    print(valueDecode);
    StreamCpt++;
  }

  @override
  Widget build(BuildContext context) {
    if (initChat == false) {
      widget.channel.sink.add(json.encode({
        'room_id': widget.room_id,
        'action': "join_room",
        'request_id': DateTime.now().toString(),
      }));
      widget.channel.sink.add(json.encode({
        'pk': widget.room_id,
        'page_number': newPageNumber,
        'action': "get_room_chat_messages",
        'request_id': DateTime.now().add(Duration(seconds: 2)).toString(),
      }));

      widget.channel.stream.listen(
        (data) => messageProcess(data),
        onDone: () {
          if (popCan == true) {
            Navigator.of(context).pop();
          }
        },
      );

      initChat = true;
    }

    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      focus = true;
    } else {
      focus = false;
    }
    return Scaffold(
      appBar: HeaderAppBar(
        text: widget.friend.username,
        textImage: widget.friend.profile_image,
      ),
      body: !loading
          ? Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: ListView(
                    controller: _scrollcontroller,
                    reverse: true,
                    children: [
                      Container(
                        height: 10,
                      ),
                      for (Message message in messageList)
                        MessageContent(message: message),
                      Container(
                        height: (loadingMessage) ? 40 : 10,
                        child: (loadingMessage)
                            ? Center(child: CircularProgressIndicator())
                            : null,
                      ),
                      Container(height: (allMessageLoad) ? 0 : 40),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        padding: EdgeInsets.only(
                          bottom: 5,
                          right: 5,
                          left: 10,
                          top: 5,
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: 50,
                                      maxHeight: focus ? 130 : 50),
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: TextFormField(
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: false,
                                      labelText: 'Envoyer un message',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 5,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                child: FloatingActionButton(
                                  onPressed: _sendMessage,
                                  tooltip: 'Envoyer un message',
                                  child: const Icon(Icons.send),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
