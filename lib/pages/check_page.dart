import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class check_page extends ConsumerWidget {
  const check_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Page'),
      ),
      body: Center(
        child: Container(
            child: Row(
          children: [
            Text('Check Page'),
            Icon(
              Icons.check_circle,
              size: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        )),
      ),
    );
  }
}
