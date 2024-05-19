import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/model/category_model.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/state/category/category_storage.dart';
import 'package:furniture_app/state/product/product_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductNotifier extends ChangeNotifier {
  double get height => _height;
  double _height = 300;
  void setHeight(double height) {
    _height = height;
    notifyListeners();
  }

  List<ProductModel?> _products = [];
  List<ProductModel?> _productsCate = [];
  final Map<String, List<ProductModel?>> _productsForCateloryId = {};

  Map<String, List<ProductModel?>> get productsForCateloryId =>
      _productsForCateloryId;
  final _productCateController =
      StreamController<List<ProductModel>>.broadcast();

  Stream<List<ProductModel>> get productCateStream =>
      _productCateController.stream;

  int get productLength => _products.length;

  
  List<ProductModel?> newProducts = [];
  
  List<ProductModel?> get products => _products;

  List<ProductModel?> get productCate => _productsCate;
  List<CategoryModel?> _categories = [];

  List<ProductModel?> get productsforIDCate => _productsforIDCate;
  List<ProductModel?> _productsforIDCate = [];
  Future<void> fetchProductForIDCate(String id) async {
    int? cateID;
    _categories.forEach((element) {
      if (element!.cateloryName == id) {
        cateID = element.cateloryId!;
      }
    });
    final respone = await ProductAPI.getProductwithIdCategory(
        cateID!, null, null, null, null, null);

    _productsforIDCate = respone;
    notifyListeners();
  }
   
  
  Future<void> newProduct() async {
    try {
      final respone = await ProductAPI.newProduct();
    newProducts =respone;
    
    } catch (e) {
      print(e);
    }
    
    notifyListeners();
  }

  void setProductsForCateloryId() {
    print(_products.length);
    for (var product in _products) {
      int index = getCategoryIndexById(product!.categoryId!);
      print(_categories.length);
      if (!_productsForCateloryId
          .containsKey(_categories[index]!.cateloryName)) {
        _productsForCateloryId.addAll({
          _categories[index]!.cateloryName as String: [product]
        });
      } else {
        _productsForCateloryId[_categories[index]!.cateloryName]!.add(product);
      }
    }
    print(_productsForCateloryId);

    notifyListeners();
  }

  int getCategoryIndexById(String cateId) {
    int cate = int.parse(cateId);
    return _categories.indexWhere((category) => category!.cateloryId == cate);
  }

  Future<void> fetchCategories() async {
    try {
      // Gọi API để lấy danh sách danh mục
      final response = await CategoriesAPI.getCatelory();

      _categories = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

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

  void fetchProductPopular() async {
    _productCateController.sink.add(_products as List<ProductModel>);
  }

  Future<void> filterCategory(int? categoryId, String? name, double? rating,
      double? minPrice, double? maxPrice, String? type) async {
    try {
      // Gọi API để lấy danh sách danh mục

      final response = await ProductAPI.getProductwithIdCategory(
          categoryId, name, rating, minPrice, maxPrice, type);
      _productsCate = response;
      _productCateController.sink.add(response);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

final productProvider = ChangeNotifierProvider((ref) => ProductNotifier());
