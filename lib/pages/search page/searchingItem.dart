import 'package:flutter/material.dart';
import 'package:furniture_app/pages/search%20page/searchPage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../collection page/collectionPage.dart';
// import '../controllers/futureProductsSearching.dart';

class searchingItem extends HookConsumerWidget {
  final String value;
  searchingItem(this.value);
  // final void callBack;
  // searchingItem(this.value, this.callBack);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvi = ref.watch(searchProvider);
    Size size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 220, 220, 220),
      child: InkWell(
        onTap: () async {
          ref.read(searchProvider.notifier).setSearch(value);
        },
        child: Container(
            width: size.width * 0.3,
            padding:
                const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    value.length > 12 ? value.substring(0, 12) + '...' : value),
              ],
            )),
      ),
    );
  }
}
