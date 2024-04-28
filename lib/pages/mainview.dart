import 'package:flutter/material.dart';
import 'package:furniture_app/provider/user_id_provider.dart';
import 'package:furniture_app/state/cart/cart_provider.dart';
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
      ref.read(cartProvider.notifier).fetchCart(userIdProvider.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(cartProvider).carts;
    print('start');
    print(products.uid);
    print(products.products?.items!.first.price);
    print(products.products?.items!.first.discountPrice);
    
    print(products.products?.total);
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
