import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yorgo/models/data/notification_model.dart';
import 'package:yorgo/models/data/room_model.dart';
import 'package:yorgo/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class NotificationProvider with ChangeNotifier {
  final String hostws = "ws://yorgoapi.herokuapp.com";
  final String host = 'https://yorgoapi.herokuapp.com';
  WebSocketChannel? channel;
  bool isLoading = false;
  int? countNotReadNotification;
  int? countNotReadMessage;
  late AuthProvider authProvider;
  late Timer timer;
  int page_number_general = 1;
  int page_number_chat = 1;
  List<NotificationModel> listNotificationGeneral = [];
  List<PrivateRoom>? listPrivateRoom;
  DateTime timestamp = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd H:m:s');
  bool allGeneralNotificationLoad = false;
  bool generalNotificationLoad = false;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (authProvider.isLoggedin != null) {
      if (authProvider.isLoggedin! && channel == null) {
        initNotification();
        getRoomsFriend();
      }
    }
  }

  initNotification() async {
    if (channel == null) {
      channel = await IOWebSocketChannel.connect(
          hostws + "/?token=" + authProvider.tokenAccess!);

      if (channel != null) {
        channel!.stream.listen(
          (data) => messageProcess(data),
          onDone: () {
            print("channel finish");
            channel!.sink.close();
            channel = null;
            initNotification();
          },
        );
        initNotificationValue();
        initTimer();
      } else {
        print("error connect");
      }
    } else {
      refreshNotification();
    }
  }

  messageProcess(data) {
    var valueDecode = json.decode(data);
    print(data.toString());
    //Compteur
    //Compteur des notifications génrale
    if (valueDecode['general_msg_type'] == 4) {
      if (countNotReadNotification != valueDecode["count"]) {
        countNotReadNotification = valueDecode["count"];
        notifyListeners();
      }
      return;
    }
    //Compteur des notifications de messages
    if (valueDecode['chat_msg_type'] == 14) {
      if (countNotReadMessage != valueDecode["count"]) {
        countNotReadMessage = valueDecode["count"];
        notifyListeners();
      }
      return;
    }

    //General notification
    if (valueDecode['general_msg_type'] == 0) {
      generalNotificationLoad = false;
      for (var notification in valueDecode['notifications']) {
        listNotificationGeneral.add(NotificationModel.fromJson(notification));
      }
      page_number_general = valueDecode['new_page_number'];
      notifyListeners();
      return;
    }
    //Chat notification
    if (valueDecode['chat_msg_type'] == 10) {
      // if (countNotReadMessage != valueDecode["count"]) {
      //   countNotReadMessage = valueDecode["count"];
      //   notifyListeners();
      // }
      return;
    }

    // New General notification
    if (valueDecode['general_msg_type'] == 3) {
      if (valueDecode["notifications"].length > 0) {
        for (var notification in valueDecode['notifications']) {
          listNotificationGeneral.insert(
              0, NotificationModel.fromJson(notification));
        }
        notifyListeners();
      }
      return;
    }

    // New chat notification
    if (valueDecode['chat_msg_type'] == 13) {
      if (valueDecode["notifications"].length > 0) {
        getRoomsFriend();
        notifyListeners();
      }
      return;
    }

    // No more general notification
    if (valueDecode['general_msg_type'] == 1) {
      allGeneralNotificationLoad = true;
      generalNotificationLoad = false;
      notifyListeners();
      return;
    }
  }

  void sendMarkNotification() {
    if (channel != null && countNotReadNotification != 0) {
      channel!.sink.add(json.encode({
        'action': "mark_notifications_read",
        'request_id': DateTime.now().toString(),
      }));
      countNotReadNotification = 0;
    }
  }

  void initTimer() {
    timer = Timer.periodic(Duration(seconds: 60), (timer) {
      refreshNotification();
    });
  }

  void refreshNotification() {
    var newest_timestamp = DateTime.now();
    // compteur
    channel!.sink.add(json.encode({
      'action': "get_unread_general_notifications_count",
      'request_id': DateTime.now().toString(),
    }));
    channel!.sink.add(json.encode({
      'action': "get_unread_chat_notification_count",
      'request_id': DateTime.now().toString(),
    }));
    //new general notification and new chat notification
    channel!.sink.add(json.encode({
      'newest_timestamp': formatter.format(newest_timestamp),
      'action': "get_new_general_notifications",
      'request_id': DateTime.now().toString(),
    }));
    channel!.sink.add(json.encode({
      'newest_timestamp': formatter.format(newest_timestamp),
      'action': "get_new_chat_notifications",
      'request_id': DateTime.now().toString(),
    }));
    timestamp = newest_timestamp;
  }

  void initNotificationValue() {
    channel!.sink.add(json.encode({
      'action': "get_unread_general_notifications_count",
      'request_id': DateTime.now().toString(),
    }));

    channel!.sink.add(json.encode({
      'action': "get_unread_chat_notification_count",
      'request_id': DateTime.now().toString(),
    }));

    channel!.sink.add(json.encode({
      'page_number': page_number_general,
      'action': "get_general_notifications",
      'request_id': DateTime.now().toString(),
    }));

    // channel!.sink.add(json.encode({
    //   'page_number': page_number_chat,
    //   'action': "get_chat_notifications",
    //   'request_id': DateTime.now().toString(),
    // }));
  }

  getOldNotification() {
    generalNotificationLoad = true;
    channel!.sink.add(json.encode({
      'page_number': page_number_general,
      'action': "get_general_notifications",
      'request_id': DateTime.now().toString(),
    }));
    notifyListeners();
  }

  Future getRoomsFriend({int? messageCount, bool? reload}) async {
    Uri url = Uri.parse("$host/api/chat/rooms");
    http.Response response = await http.get(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
    );

    if (response.statusCode != 200) {
      return null;
    } else {
      var rooms = json.decode(utf8.decode(response.bodyBytes));
      List<PrivateRoom> listRoom = [];
      for (var room in rooms) {
        listRoom.add(PrivateRoom.fromJson(room));
      }
      listRoom.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      listPrivateRoom = listRoom;
      notifyListeners();
      return listRoom;
    }
  }

  Future getOrCreateRoomFriend(dynamic friend) async {
    Map<String, String> mapRequest = {};
    mapRequest['user2_id'] = friend.id.toString();
    Uri url = Uri.parse("$host/api/chat/create_or_return_private_chat/");
    http.Response response = await http.post(
      url,
      headers: {'authorization': 'Bearer ${authProvider.tokenAccess}'},
      body: mapRequest,
    );

    if (response.statusCode != 201) {
      return null;
    } else {
      var room = json.decode(utf8.decode(response.bodyBytes));
      this.getRoomsFriend();
      return room["chatroom_id"];
    }
  }
}
