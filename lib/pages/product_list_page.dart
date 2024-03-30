import 'package:flutter/material.dart';
import 'package:furniture_app/components/gripview_product.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/state/product/product_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  final String index;
  const ProductListPage(this.index, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  @override
  void initState() async {
    Future.delayed(Duration.zero, () {
      ref.read(productProvider).fetchProduct();
      ref.read(productProvider).filterCategory(widget.index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productProvider);
    return Scaffold(
      body: GripViewProduct(
        products: productList as List<ProductModel>,
        length: productList.productLength,
      ),
    );
  }
}
