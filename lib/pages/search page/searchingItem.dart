import 'package:flutter/material.dart';

// import '../../collection page/collectionPage.dart';
// import '../controllers/futureProductsSearching.dart';

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
              ],
            )),
      ),
    );
  }
}
