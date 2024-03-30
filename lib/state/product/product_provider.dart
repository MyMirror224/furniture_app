import 'package:flutter/material.dart';
import 'package:furniture_app/extension/sort_product.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/state/product/product_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductNotifier extends ChangeNotifier {
  List<ProductModel?> _products = [];

  int get productLength => _products.length;

  List<ProductModel?> get products => _products;

  Future<void> fetchProduct() async {
    try {
      // Gọi API để lấy danh sách danh mục
      final response = await ProductAPI.getProduct();
      _products = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<ProductModel?> filterCategory(String category) {
    return _products.filterByCategory(category);
  }
}

final productProvider = ChangeNotifierProvider((ref) => ProductNotifier());
