import 'package:flutter/material.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/components/notify_view.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  int index = 2;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff93B1A6),
      body: SafeArea(
        
        child: Column(
          children: [
            Row(
              children: [
                HomeAppBar(),
                Gap(20),
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Gap(10),
            Expanded(child:   NotifyView()),
          ],
        ),
      ),
    );
  }
}
