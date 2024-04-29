import 'package:flutter/material.dart';
import 'package:furniture_app/model/category_model.dart';
import 'package:furniture_app/state/category/category_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryNotifier extends ChangeNotifier {
  List<CategoryModel?> _categories = [];

  List<CategoryModel?> get categories => _categories;

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
}

final categoryProvider = ChangeNotifierProvider((ref) => CategoryNotifier());
