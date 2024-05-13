import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/state/order/order_provider.dart';
import 'package:furniture_app/state/review/review_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderCancelPage extends ConsumerStatefulWidget {
  final String typeSend;
  final int order_id;
  const OrderCancelPage({
    Key? key,
    required this.typeSend,
    required this.order_id,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderCancelPageState();
}

class _OrderCancelPageState extends ConsumerState<OrderCancelPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Reason'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reason',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your reason here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final message = _messageController.text;
                if (widget.typeSend == 'Refund Order') {
                  await ref
                      .read(orderProvider.notifier)
                      .refundOrder(widget.order_id, message);
                } else if (widget.typeSend == 'Cancel Order') {
                  await ref
                      .read(orderProvider.notifier)
                      .cancelOrder(widget.order_id, message);
                } else {
                  //tracking
                }
                final message2 = await ref.watch(orderProvider).message;
                
                if (message2 == 'Cancel success') {
                  await Fluttertoast.showToast(
                    msg: "Request sent successfully  ",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: const Color(0xff193d3d),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  
                  
                } else {
                  await Fluttertoast.showToast(
                    msg: "Request sent failed",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: const Color(0xff193d3d),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                Navigator.pop(context);
              },
              child: Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
