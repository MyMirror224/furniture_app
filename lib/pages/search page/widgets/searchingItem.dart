import 'package:flutter/material.dart';

class searchingItem extends StatelessWidget {
  final String value;
  searchingItem(this.value);
  // final void callBack;
  // searchingItem(this.value, this.callBack);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 220, 220, 220),
      child: InkWell(
        onTap: () async {
          // //saving the searching value
          // Navigator.push(
          //     context,
          //     PageTransition( //pagetranstion là dùng để chuyển trang mà không cần phải pop ra khỏi trang hiện tại và push vào trang mới như cách thông thường
          //         type: PageTransitionType.rightToLeftWithFade, // kiểu chuyển trang từ phải qua trái với hiệu ứng fade
          //         child: CollectionPage(futureProductsSearching(value)),
          //         childCurrent: context.widget));

          // //achieve the result of
          // await SharedPreferencesObject().saveSearchingHistory(value);
        },
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value),
                const SizedBox(
                  width: 5,
                ),
                InkWell(onTap: () {}, child: const Icon(Icons.close_rounded))
              ],
            )),
      ),
    );
  }
}
