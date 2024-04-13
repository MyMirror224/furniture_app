import 'package:flutter/material.dart';
import 'package:furniture_app/components/grip_view_search.dart';
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
  final int index;
  const ProductListPage(this.index, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  String? _selectedFilter;
  String? _selectedPrice;
  double? rating;
  String? text;
  String? name;
  String? type;
  String? _selectedRating;
  String? _selectedType;
  double _minPrice = 0;
  double? _maxPrice;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      ref
          .read(productProvider)
          .filterCategory(widget.index, null, null, null, null, null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvi = ref.watch(searchProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: ref.watch(productProvider).height,
            pinned: true,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonBackIos(),
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
                                searchProvi.saveSearchingHistory(v);
                              },
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (searchProvi
                                      .controllerTextField.text.isNotEmpty) {
                                    searchProvi.saveSearchingHistory(
                                        searchProvi.controllerTextField.text);
                                    ref
                                        .read(productProvider.notifier)
                                        .filterCategory(
                                            widget.index, 
                                            searchProvi
                                                .controllerTextField.text,
                                            rating,
                                            _minPrice,
                                            _maxPrice,
                                            type);
                                  }
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
                            //ref.read(productProvider.notifier).setHeight(400);
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
                                          i >= 0 &&
                                              snapshot.data!.length - i <= 3;
                                          i--)
                                        searchingItem(snapshot.data![i])
                                    ],
                                  ),
                                ]);
                          } else {
                            //ref.read(productProvider.notifier).setHeight(300);

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
                      selectedColor: Color(0xFF93B1A6),
                      label: Text('Price low to high'),
                      selected: _selectedType == 'Price low to high',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedType = selected ? 'Price low to high' : null;
                          if (_selectedType != null) {
                            type = 'asc';
                          } else {
                            type = 'null';
                          }
                          ref.read(productProvider.notifier).filterCategory(
                              widget.index,
                              searchProvi.controllerTextField.text,
                              rating,
                              _minPrice,
                              _maxPrice,
                              type);

                          // Lọc danh sách sản phẩm theo giá tăng dần
                          //productList.sort((a, b) => a.price.compareTo(b.price));
                        });
                      },
                    ),
                    ChoiceChip(
                      selectedColor: Color(0xFF93B1A6),
                      label: Text('Price high to low'),
                      selected: _selectedType == 'Price high to low',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedType = selected ? 'Price high to low' : null;
                          // Lọc danh sách sản phẩm theo giá giảm dần
                          if (_selectedType != null) {
                            type = 'desc';
                          } else {
                            type = null;
                          }
                          ref.read(productProvider.notifier).filterCategory(
                              widget.index,
                              searchProvi.controllerTextField.text,
                              rating,
                              _minPrice,
                              _maxPrice,
                              type); //products.sort((a, b) => b.price.compareTo(a.price));
                        });
                      },
                    ),
                    ChoiceChip(
                      selectedColor: Color(0xFF93B1A6),
                      label: Text('5*'),
                      selected: _selectedRating == '5*',
                      onSelected: (bool selected) {
                        setState(
                          () {
                            _selectedRating = selected ? '5*' : null;
                            if (_selectedRating != null) {
                              rating = 5;
                            } else {
                              rating = null;
                            }
                            ref.read(productProvider.notifier).filterCategory(
                                widget.index,
                                searchProvi.controllerTextField.text,
                                rating,
                                _minPrice,
                                _maxPrice,
                                type);
                          },
                        );
                      },
                    ),
                    ChoiceChip(
                      selectedColor: Color(0xFF93B1A6),
                      label: Text('>= 4*'),
                      selected: _selectedRating == '>= 4*',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedRating = selected ? '>= 4*' : null;
                          if (_selectedRating != null) {
                            rating = 4;
                          } else {
                            rating = null;
                          }
                          ref.read(productProvider.notifier).filterCategory(
                              widget.index,
                              searchProvi.controllerTextField.text,
                              rating,
                              _minPrice,
                              _maxPrice,
                              type);
                        });
                      },
                    ),
                    ChoiceChip(
                      selectedColor: Color(0xFF93B1A6),
                      label: Text('>= 3*'),
                      selected: _selectedRating == '>= 3*',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedRating = selected ? '>= 3*' : null;
                          if (_selectedRating != null) {
                            rating = 3;
                          } else {
                            rating = null;
                          }
                          ref.read(productProvider.notifier).filterCategory(
                              widget.index,
                              searchProvi.controllerTextField.text,
                              rating,
                              _minPrice,
                              _maxPrice,
                              type);
                        });
                      },
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text('Price'),
                          selectedColor: Color(0xFF93B1A6),
                          selected: _selectedPrice == 'Price',
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedPrice = selected ? 'Price' : null;
                              if (_selectedPrice == null) {
                                _maxPrice = null;
                                _minPrice = 0;
                                ref
                                    .read(productProvider.notifier)
                                    .filterCategory(
                                        widget.index,
                                        searchProvi.controllerTextField.text,
                                        rating,
                                        _minPrice,
                                        _maxPrice,
                                        type);
                              }
                            });
                          },
                        ),
                        if (_selectedPrice == 'Price')
                          Expanded(
                            child: Row(
                              children: [
                                Gap(10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Minimum price',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _minPrice = double.tryParse(value) ?? 0;
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                    child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Maximum price',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _maxPrice = double.tryParse(value);
                                  },
                                )),
                                Gap(10),
                                Expanded(
                                  child: ChoiceChip(
                                    selectedColor: Color(0xFF93B1A6),
                                    label: Text('Apply'),
                                    selected: _selectedFilter == 'Áp Dụng',
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedFilter =
                                            selected ? 'Apply' : null;
                                        if (_selectedFilter == null) {
                                          _minPrice = 0;
                                          _maxPrice = null;
                                        }
                                        ref
                                            .read(productProvider.notifier)
                                            .filterCategory(
                                                widget.index,
                                                searchProvi
                                                    .controllerTextField.text,
                                                rating,
                                                _minPrice,
                                                _maxPrice,
                                                type);
                                      });
                                    },
                                  ),
                                ),
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
                return StreamBuilder<List<ProductModel?>>(
                  stream: ref.watch(productProvider).productCateStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GripViewSearch(
                        productsStream: snapshot.data!,
                        length: snapshot.data!.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
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
