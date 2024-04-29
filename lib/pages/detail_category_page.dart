import 'package:flutter/material.dart';
import 'package:furniture_app/components/HomeAppBar.dart';
import 'package:furniture_app/components/grip_view_search.dart';
import 'package:furniture_app/pages/cart_page.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailCategoryPage extends ConsumerStatefulWidget {
  final String cateName;
  const DetailCategoryPage({required this.cateName, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailCategoryPageState();
}

class _DetailCategoryPageState extends ConsumerState<DetailCategoryPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchProductForIDCate(widget.cateName);
      debugPrint('cateName: ${widget.cateName} ');
      debugPrint("nhận: " + widget.cateName);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider).productsForCateloryId;
    final userId = ref.watch(userIdProvider);
    final productsID = ref.watch(productProvider).productsforIDCate;
    debugPrint(productsID.toString());
    debugPrint("check: +++ " + products.length.toString());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeAppBar(),
                    Text(
                      widget.cateName,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                            ),
                          );
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
              ),
              // GripViewProduct(
              //   productsStream: Stream.fromIterable(
              //     productsID,
              //   ),
              //   length: productsID.length.toInt(),
              // ),
              GripViewSearch(
                productsStream: productsID.toList(),
                length: productsID.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
