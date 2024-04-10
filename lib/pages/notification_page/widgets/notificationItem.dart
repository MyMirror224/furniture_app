import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/notification/notification.dart';
import '../controller/futureReadNoti.dart';

class notificationItem extends StatefulWidget {
  NotificationModel notiData;
  late bool isRead;

  notificationItem(this.notiData) {
    this.isRead = (notiData.isSeen == 0 ? false : true);
  }

  @override
  State<notificationItem> createState() => _notificationItemState();
}

class _notificationItemState extends State<notificationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isRead == false) {
          setState(() {
            futureReadNotification(widget.notiData.iDNoti);
            widget.isRead = true;
          });
        }
        if (widget.notiData.type == 2) {
          // futureGetOrderDetail(int.parse(widget.notiData.note!)).then((value) =>
          //     Navigator.push(
          //         context,
          //         PageTransition(
          //             type: PageTransitionType.rightToLeftWithFade,
          //             child: OrderDetailPage(value),
          //             childCurrent: widget)));
        }
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.isRead == true
                    ? Colors.white
                    : Color.fromRGBO(255, 251, 240, 1.0),
                border: Border.all(color: Color.fromRGBO(233, 222, 228, 1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.notiData.type == 1)
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(500)),
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        child: const Icon(Icons.notifications,
                            color: Colors.white),
                      )
                    else if (widget.notiData.type == 2)
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(69, 207, 47, 1),
                            borderRadius: BorderRadius.circular(500)),
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        child:
                            const Icon(Icons.fire_truck, color: Colors.white),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.notiData.title),
                        Text(DateFormat.yMd().add_jm().format(
                            DateTime.tryParse(widget.notiData.createdOn)!))
                      ],
                    )
                  ],
                ),
                Text(
                  widget.notiData.content,
                  maxLines: 5,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          if (widget.isRead != true)
            Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(500)),
            )
        ],
      ),
    );
  }
}
