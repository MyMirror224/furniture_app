import 'package:flutter/material.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/state/order/order_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderNotifier extends ChangeNotifier {
  List<OrderShowUi> get orders => _orders;
  List<OrderShowUi> _orders = [];
  
  List<OrderModel> _ordersModel = [];
  int get currentFilter => _crurentFilter;

  int _crurentFilter = 0;

  Future<void> setCurrentFilter(int value) async {
    _crurentFilter = value;
    notifyListeners();
  }

  Future<void> fetchOrder(String uid) async {
    final response = await OrderApi.getModel(uid);
    _ordersModel = response;
    for (var order in _ordersModel) {
      final products = order.products;
      for (var product in products) {
        OrderShowUi orderShowUi = OrderShowUi(
          id: order.id,
          name: order.name,
          total_price: order.total_price,
          address: order.address,
          phone_number: order.phone_number,
          note: order.note,
          type: order.type,
          status: order.status,
          is_done: order.is_done,
          product_id: product.product_id,
          nameProduct: product.name,
          image: product.image,
          price: product.price,
          quantity: product.quantity,
          uid: order.uid,
        );
        _orders.add(orderShowUi);
      }
      notifyListeners();
    }
  }
}

final orderProvider = ChangeNotifierProvider((ref) => OrderNotifier());
