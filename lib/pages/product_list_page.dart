import 'package:flutter/material.dart';
import 'package:furniture_app/components/grip_view_search.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/pages/cart_page.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:furniture_app/pages/search%20page/searchPage.dart';
import 'package:furniture_app/pages/search%20page/searchingItem.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/services/constain.dart';
import 'package:furniture_app/services/shared%20preferences/sharedPreferences.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  final int index;
  final String? nameSearch;
  const ProductListPage(this.index, this.nameSearch, {Key? key})
      : super(key: key);

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index == 0) {
        ref.read(productProvider).fetchProductPopular();
      } else {
        ref.read(productProvider).filterCategory(
            widget.index, widget.nameSearch, null, null, null, null);
      }
      if (widget.nameSearch == null)
        ref.read(productProvider).fetchProductPopular();
      else {
        ref.read(productProvider).filterCategory(
            widget.index, widget.nameSearch, null, null, null, null);
      }
      ;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvi = ref.watch(searchProvider);
    final userId = ref.watch(userIdProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 52, 125, 105),
            toolbarHeight: size.height * 0.4,
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CartPage(userId!.toString()),
                              ));
                        },
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Gap(size.width * 0.05),
                          Expanded(
                            child: TextField(
                              // autofocus: true,
                              focusNode: searchProvi.focusNode,
                              controller: searchProvi.controllerTextField,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isCollapsed: true,
                                // focusColor: Colors.transparent,
                                hintText: searchHint,
                              ),

                              onChanged: (v) {
                                //request to get autocomplete searching value
                                //check to can click to clear or not
                                bool canClearTemp;
                                if (v.isNotEmpty) {
                                  canClearTemp = true;
                                } else {
                                  canClearTemp = false;
                                }
                                if (searchProvi.canClear != canClearTemp) {
                                  searchProvi.canClean();
                                }
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
                                        .setHeight(400);
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
                                  height: size.height * 0.05,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xff193d3d),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // "search".tr(),
                                        search,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                                       Text(historySearch),
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(productProvider.notifier)
                                              .setHeight(300);
                                          SharedPreferencesObject()
                                              .clearSearchingHistory();
                                          searchProvi.changeTemp();
                                        },
                                        child: Row(
                                          children:  [
                                            Text(removeAll),
                                            Icon(Icons.close_rounded),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    spacing: 3,
                                    runSpacing: 1,
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
                      label: Text(priceLowToHigh),
                      selected: _selectedType == priceLowToHigh,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedType = selected ? priceLowToHigh: null;
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
                      label: Text(priceHighToLow),
                      selected: _selectedType == priceHighToLow,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedType = selected ? priceHighToLow : null;
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
                    Row(
                      children: [
                        Wrap(
                          spacing: 8,
                          children: [
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
                                  ref
                                      .read(productProvider.notifier)
                                      .filterCategory(
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
                                  ref
                                      .read(productProvider.notifier)
                                      .filterCategory(
                                          widget.index,
                                          searchProvi.controllerTextField.text,
                                          rating,
                                          _minPrice,
                                          _maxPrice,
                                          type);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text(price),
                          selectedColor: Color(0xFF93B1A6),
                          selected: _selectedPrice == price,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedPrice = selected ? price : null;
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
                        if (_selectedPrice == price)
                          Expanded(
                            child: Row(
                              children: [
                                Gap(10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: minimumPrice,
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
                                    labelText: maximumPrice,
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
                                    label: Text(apply),
                                    selected: _selectedFilter == apply,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedFilter =
                                            selected ? apply : null;
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
