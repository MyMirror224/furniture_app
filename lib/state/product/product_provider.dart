import 'package:flutter/material.dart';
import 'package:furniture_app/extension/sort_product.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/state/product/product_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductNotifier extends ChangeNotifier {
  double get height => _height;
  double _height = 300;
  void setHeight(double height){
    _height = height;
    notifyListeners();
  }
  List<ProductModel?> _products = [];
  List<ProductModel?> _productsCate = [];


  int get productLength => _products.length;

  List<ProductModel?> get products => _products;

  List<ProductModel?> get productCate => _productsCate;

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

  Future<void> filterCategory(String? categoryId, String? name, double? rating, double? minPrice, double? maxPrice, String? type) async {
    try {
      // Gọi API để lấy danh sách danh mục
      final response = await ProductAPI.getProductwithIdCategory(categoryId, name, rating, minPrice, maxPrice, type);
      _productsCate = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
} 

final productProvider = ChangeNotifierProvider((ref) => ProductNotifier());
