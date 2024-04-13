import 'package:flutter/material.dart';
import 'package:furniture_app/model/cart_model.dart';
import 'package:furniture_app/state/cart/cart_storage.dart';

class CartNotifier  extends ChangeNotifier {
  CartModel get carts => _carts;
  CartModel _carts = CartModel();

  Future<void> fetchCart() async {
    try { 
      final response = await CartApi.getCart();
      _carts = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
}
  Future<void> changQuantity(int index, int quantity) async {
    try {
      _carts.products!.items![index].quantity = quantity;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}