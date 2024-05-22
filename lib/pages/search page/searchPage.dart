import 'package:flutter/material.dart';
import 'package:furniture_app/pages/search%20page/searchingItem.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/shared preferences/sharedPreferences.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvi = ref.watch(searchProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: SharedPreferencesObject()
                              .futureGetSearchingHistory(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>?> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("History searching "),
                                        InkWell(
                                          onTap: () {
                                            SharedPreferencesObject()
                                                .clearSearchingHistory();
                                            searchProvi.changeTemp();
                                          },
                                          child: Row(
                                            children: const [
                                              Text("Delete all"),
                                              Icon(Icons.close_rounded),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        for (var i in snapshot.data!)
                                          searchingItem(i)
                                      ],
                                    ),
                                  ]);
                            } else {
                              return Container();
                            }
                          }),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: SharedPreferencesObject()
                                      .futureGetSearchingHistory(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<String>?> snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Lịch sử tìm kiếm"),
                                                InkWell(
                                                  onTap: () {
                                                    SharedPreferencesObject()
                                                        .clearSearchingHistory();
                                                    searchProvi.changeTemp();
                                                  },
                                                  child: Row(
                                                    children: const [
                                                      Text("Xóa tất cả"),
                                                      Icon(Icons.close_rounded),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Wrap(
                                              spacing: 5,
                                              runSpacing: 5,
                                              children: [
                                                for (var i in snapshot.data!)
                                                  searchingItem(i)
                                              ],
                                            ),
                                          ]);
                                    } else {
                                      return Container();
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final searchProvider = ChangeNotifierProvider((ref) => SearchNotifier());

class SearchNotifier extends ChangeNotifier {
  int _temp = 0;
  int get temp => _temp;
  double get height => _height;
  double _height = 300;

  final TextEditingController _controllerTextField = TextEditingController();
  TextEditingController get controllerTextField => _controllerTextField;
  bool _canClear = false;
  bool get canClear => _canClear;
  FocusNode get focusNode => _focusNode;
  final FocusNode _focusNode = FocusNode();
  void setSearch(String value) {
    _controllerTextField.text = value;
    notifyListeners();
  }

  void changeHeight() {
    if (_height == 300) {
      _height = 400;
    } else {
      _height = 300;
    }
  }

  void clean() {
    _canClear = false;
    notifyListeners();
  }

  void canClean() {
    _canClear = true;
    notifyListeners();
  }

  void changeTemp() {
    _temp++;
    notifyListeners();
  }

  void saveSearchingHistory(String value) async {
    await SharedPreferencesObject().saveSearchingHistory(value);
    notifyListeners();
  }
}
