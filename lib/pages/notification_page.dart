import 'package:flutter/material.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/components/notify_view.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/state/notify/notify_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerStatefulWidget {
  final String uid;
  const NotificationPage(this.uid, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notifyProvider.notifier).fetchNotification(widget.uid);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(notifyProvider).notifications;
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
                  context.loc.notification,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Gap(10),
            Expanded(
                child: NotifyView(
              lists: lists,
            )),
          ],
        ),
      ),
    );
  }
}
