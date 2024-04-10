import 'package:flutter/material.dart';
import 'package:furniture_app/components/gripview_product.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:furniture_app/pages/search%20page/searchPage.dart';
import 'package:furniture_app/pages/search%20page/searchingItem.dart';
import 'package:furniture_app/services/shared%20preferences/sharedPreferences.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  final String index;
  const ProductListPage(this.index, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  String? _selectedFilter;
  double _minPrice = 0;
  double _maxPrice = double.infinity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 2), () {
      ref.read(productProvider).filterCategory(widget.index, null, null, null, null, null);
    });
  }

 

  @override
  Widget build(BuildContext context) {
    final searchProvi = ref.watch(searchProvider);
    final productList = ref.watch(productProvider).productCate;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 300,
            pinned: true,
            expandedHeight: 100,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     ButtonBackIos(
                      notify: ref.read(productProvider.notifier).fetchProduct(),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xFF183D3D),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffb3cac2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Gap(10),
                          Expanded(
                            child: TextField(
                              // autofocus: true,
                              focusNode: searchProvi.focusNode,
                              controller: searchProvi.controllerTextField,
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
                                if (searchProvi.canClear != canClearTemp)
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
                            children: [
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
                                      searchProvi.controllerTextField.text);
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
                  ),
                ]),
                const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: SharedPreferencesObject()
                            .futureGetSearchingHistory(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>?> snapshot) {
                          if (snapshot.hasData) {
                            
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                      
                                      for (var i = snapshot.data!.length - 1;
                                          i>=0 && snapshot.data!.length - i <= 3;
                                          i--)
                                        searchingItem(snapshot.data![i])
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
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: Text('Giá tăng dần'),
                      selected: _selectedFilter == 'Giá tăng dần',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedFilter = selected ? 'Giá tăng dần' : null;
                          // Lọc danh sách sản phẩm theo giá tăng dần
                          //productList.sort((a, b) => a.price.compareTo(b.price));
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('Giá giảm dần'),
                      selected: _selectedFilter == 'Giá giảm dần',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedFilter = selected ? 'Giá giảm dần' : null;
                          // Lọc danh sách sản phẩm theo giá giảm dần
                          //products.sort((a, b) => b.price.compareTo(a.price));
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('5*'),
                      selected: _selectedFilter == '5*',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedFilter = selected ? '5*' : null;
                          // Lọc danh sách sản phẩm có đánh giá 5 sao
                          //products.removeWhere((product) => product.rating < 5);
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('3* trở lên'),
                      selected: _selectedFilter == '3* trở lên',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedFilter = selected ? '3* trở lên' : null;
                         
                          
                        });
                      },
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text('Số tiền'),
                          selected: _selectedFilter == 'Số tiền',
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedFilter = selected ? 'Số tiền' : null;
                            });
                          },
                        ),
                        if (_selectedFilter == 'Số tiền')
                          Expanded(
                            child: Row(
                              children: [
                                Gap(10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Giá tối thiểu',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _minPrice = double.tryParse(value) ?? 0;
                                      // Lọc danh sách sản phẩm theo khoảng giá
                                      //products.removeWhere((product) => product.price < _minPrice || product.price > _maxPrice);
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Giá tối đa',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _maxPrice = double.tryParse(value) ??
                                          double.infinity;
                                      // Lọc danh sách sản phẩm theo khoảng giá
                                      //products.removeWhere((product) => product.price < _minPrice || product.price > _maxPrice);
                                    },
                                  ),
                                ),
                                Gap(10)
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GripViewProduct(
                  products: productList,
                  length: productList.length,
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
