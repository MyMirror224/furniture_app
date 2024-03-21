import 'package:flutter/material.dart';
import 'package:furniture_app/components/top%20navigation/topNavigation.dart';
import 'package:furniture_app/models/notification/notification.dart';
import 'package:furniture_app/pages/notification_page/widgets/notificationItem.dart';

import 'controller/futureGetNoti.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TopNavigation(
            left: Text("notifications",
                style: Theme.of(context).textTheme.titleMedium),
            isSearcher: false,
          ), // TopNavigation(

          Expanded(
              child: FutureBuilder<List<NotificationModel>>(
                  future: futureGetNotification(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10 / 2),
                        children: [
                          for (var i in snapshot.data!.reversed)
                            notificationItem(i)
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })),
        ],
      )),
    );
  }
}
