import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/state/review/review_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WriteReviewPage extends ConsumerStatefulWidget {
  final int product_id;
  final int order_id;
  final String uid;
  const WriteReviewPage(
      {Key? key,
      required this.product_id,
      required this.order_id,
      required this.uid})
      : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WriteReviewPageState();
}

class _WriteReviewPageState extends ConsumerState<WriteReviewPage> {
  final TextEditingController _messageController = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.writeReview),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.rating,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      _rating > index ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                context.loc.message,
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
                  hintText: context.loc.writeYourReview,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final message = _messageController.text;
                  await ref.read(productReviewsProvider.notifier).addReview(
                      widget.product_id,
                      widget.order_id,
                      message,
                      _rating,
                      widget.uid);
                  final message2 =
                      await ref.watch(productReviewsProvider).message;
                  if (message2 == 'success') {
                    await Fluttertoast.showToast(
                      msg: context.loc.reviewSuccess,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0xff193d3d),
                      textColor: Colors.white,
                      fontSize: 20.0,
                    );
                    Navigator.pop(context);
                  } else {
                    await Fluttertoast.showToast(
                      msg: context.loc.reviewFailed,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0xff193d3d),
                      textColor: Colors.white,
                      fontSize: 20.0,
                    );
                  }
                },
                child: Text(context.loc.submitReview),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
