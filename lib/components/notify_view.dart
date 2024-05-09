import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifyView extends HookConsumerWidget {
  const NotifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> list = [
      '1sssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      '2ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      '3',
      '4',
      '5',
      '6',
      '7',
      '1',
      '2sssssssssssssssssssssssssssssssssssssss',
      '3',
      '4',
      '5',
      '6',
      '7sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
    ];
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final String text = list[index];
          return InkWell(
            onTap: () {
              
            },
            child: Container(
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
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100 * 0.9),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close))
                ]),
                Row(children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100 * 0.9),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ]),
              ]),
            ),
          );
        });
  }
}
