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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // quay lại trang trước
              Material(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left)),
              ),
              // search bar
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color(0xffb3cac2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          // autofocus: true,
                          focusNode: searchProvi._focusNode,
                          controller: searchProvi._controllerTextField,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isCollapsed: true,
                            // focusColor: Colors.transparent,
                            hintText: 'Input search here...',
                          ),

                          onChanged: (v) {
                            //request to get autocomplete searching value
                            //check to can click to clear or not
                            bool canClearTemp;
                            if (v.length > 0)
                              canClearTemp = true;
                            else
                              canClearTemp = false;
                            if (searchProvi._canClear != canClearTemp)
                              searchProvi.canClean();
                          },
                          onSubmitted: (v) async {
                            //saving the searching value
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //       type: PageTransitionType.rightToLeftWithFade,
                            //       child: CollectionPage(
                            //           futureProductsSearching(v)),
                            //       childCurrent: context.widget),
                            // );
                            // //achieve the result of
                            searchProvi.saveSearchingHistory(v);
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: searchProvi._canClear
                                ? InkWell(
                                    onTap: () {
                                      searchProvi._controllerTextField.clear();
                                      searchProvi.clean();
                                    },
                                    child: const Icon(Icons.close),
                                  )
                                :
                                // InkWell(
                                //     onTap: () {
                                //       // Navigator.push(
                                //       //     context,
                                //       //     MaterialPageRoute(
                                //       //         builder: (_) =>
                                //       //             const qrScannerPage()));
                                //     },
                                //     child: const Icon(
                                //         Icons.qr_code_scanner_outlined),
                                //   ),
                                null,
                          ),
                          InkWell(
                            onTap: () async {
                              //saving the searching value
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         type: PageTransitionType
                              //             .rightToLeftWithFade,
                              //         child: CollectionPage(
                              //             futureProductsSearching(
                              //                 _controllerTextField.text)),
                              //         childCurrent: context.widget)
                              //         );

                              //achieve the result of
                              searchProvi.saveSearchingHistory(
                                  searchProvi._controllerTextField.text);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xff193d3d),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                // "search".tr(),
                                "Search",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                FutureBuilder(
                    future:
                        SharedPreferencesObject().futureGetSearchingHistory(),
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
                                  for (var i in snapshot.data!) searchingItem(i)
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
    )));
  }
}

final searchProvider = ChangeNotifierProvider((ref) => SearchNotifier());

class SearchNotifier extends ChangeNotifier {
  int _temp = 0;
  int get temp => _temp;
  double get height =>_height;
  double _height = 300;

  final TextEditingController _controllerTextField = TextEditingController();
  TextEditingController get controllerTextField => _controllerTextField;
  bool _canClear = false;
  bool get canClear => _canClear;
  FocusNode get focusNode => _focusNode;
  final FocusNode _focusNode = FocusNode();
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
