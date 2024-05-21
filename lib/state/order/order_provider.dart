import 'package:flutter/material.dart';
import 'package:furniture_app/model/order_model.dart';
import 'package:furniture_app/state/order/order_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderNotifier extends ChangeNotifier {
  List<OrderModel> get orders => _orders;
  List<OrderModel> _orders = [];

  int get currentFilter => _crurentFilter;

  int _crurentFilter = 0;

  Future<void> setCurrentFilter(int value) async {
    _crurentFilter = value;
    notifyListeners();
  }

  Future<void> fetchOrder(String uid) async {
    _orders = [];
    final response = await OrderApi.getModel(uid);
    for (var i = response.length - 1; i >= 0; i--) {
      _orders.add(response[i]);
    }
    notifyListeners();
  }

  String get stringbutton => _stringbutton;
  String message = '';
  String _stringbutton = '';
  String get reviews => 'reviews';
  Future<void> setStringAndButtonShow(String s1, String s2) async {
    _stringbutton = '';
    if ('Pending' == s1 && 'direct' == s2) {
      _stringbutton = 'Cancel Order';
    } else {
      if ('Pending' == s1) {
        _stringbutton = 'Refund Order';
      }
      if ('Delivering' == s1) {
        _stringbutton = 'Tracking Order';
      }
    }
    notifyListeners();
  }

  Future<void> cancelOrder(int id, String mess) async {
    message = '';
    final response = await OrderApi.cancelOrder(id, mess);
    message = response;
    notifyListeners();
  }
}

final orderProvider = ChangeNotifierProvider((ref) => OrderNotifier());
