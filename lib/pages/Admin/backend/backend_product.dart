import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productProvider = ChangeNotifierProvider((ref) => ProductProvider());

class ProductProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String? searchName = '';
  String? categoryId = '';
  String? categoryName = '';
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('furniture');
  CollectionReference cateRef =
      FirebaseFirestore.instance.collection('category');
  void changeSearch(String value) {
    searchName = value;
    notifyListeners();
  }

  void changeCategory(String value) {
    categoryId = value;
    notifyListeners();
  }
}
