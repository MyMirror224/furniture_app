import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/product/product_provider.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(productProvider).fetchProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider).products;
    print(products.firstOrNull?.productName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Furniture App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Furniture App'),
            ElevatedButton(
              onPressed: () {},
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
