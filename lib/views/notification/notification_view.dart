import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yorgo/models/data/notification_model.dart';
import 'package:yorgo/providers/notification_provider.dart';
import 'package:yorgo/views/notification/widget/NotificationButton.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  ScrollController _scrollcontroller = ScrollController();
  bool loadingNotificationGeneral = false;
  bool allMessageLoad = false;

  @override
  void initState() {
    super.initState();
    _scrollcontroller = ScrollController()..addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollcontroller.position.extentAfter == 0 &&
        loadingNotificationGeneral != true &&
        allMessageLoad != true) {
      await Provider.of<NotificationProvider>(context, listen: false)
          .getOldNotification();
      //items.addAll(List.generate(42, (index) => 'Inserted $index'));

    }
  }

  @override
  Widget build(BuildContext context) {
    final List<NotificationModel> listeNotificationGeneral =
        Provider.of<NotificationProvider>(context).listNotificationGeneral;
    loadingNotificationGeneral =
        Provider.of<NotificationProvider>(context).generalNotificationLoad;
    allMessageLoad =
        Provider.of<NotificationProvider>(context).allGeneralNotificationLoad;
    if (listeNotificationGeneral != 0) {
      Provider.of<NotificationProvider>(context).sendMarkNotification();
    }
    return Container(
      color: Colors.white,
      child: listeNotificationGeneral.length != 0
          ? ListView(
              controller: _scrollcontroller,
              children: [
                for (var notification in listeNotificationGeneral)
                  NotificationButton(notification: notification),
                Container(
                    padding: (loadingNotificationGeneral == true)
                        ? const EdgeInsets.all(8.0)
                        : null,
                    child: (loadingNotificationGeneral == true)
                        ? Center(child: CircularProgressIndicator())
                        : null),
              ],
            )
          : Center(
              child: Text("Vous n'avez pas de notification.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
    );
  }
}
