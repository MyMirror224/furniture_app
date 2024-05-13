import 'package:flutter/material.dart';
import 'package:furniture_app/model/notify_model.dart';
import 'package:furniture_app/pages/Invoice_history_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';

import 'package:furniture_app/state/notify/notify_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifyView extends HookConsumerWidget {
  final List<NotificationModel> lists;
  const NotifyView({required this.lists, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    return ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          final list = lists[index];
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(notifyProvider.notifier)
                          .updateNotification(list.id!, userId.toString(), 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryInvoicePage(
                            uid: userId.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100 * 0.9),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        list.title!,
                        style: TextStyle(
                            color: list.isread == 0 ? Colors.black : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      ref
                          .read(notifyProvider.notifier)
                          .updateNotification(list.id!, userId.toString(), 2);
                    },
                    icon: Icon(Icons.close))
              ]),
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(notifyProvider.notifier)
                          .updateNotification(list.id!, userId.toString(), 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryInvoicePage(
                            uid: userId.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100 * 0.9),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        list.body!,
                        style: TextStyle(
                            color:list.isread == 0 ? Colors.black : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ]),
            ]),
          );
        });
  }
}
