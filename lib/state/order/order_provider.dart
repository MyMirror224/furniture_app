import 'package:flutter/material.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/state/order/order_storage.dart';

class Order extends ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  Future<void> fetchOrder() async {
    try {
      final response = await OrderApi.getModel();
      _orders = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  

  
}