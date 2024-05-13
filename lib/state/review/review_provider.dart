import 'package:flutter/material.dart';
import 'package:furniture_app/model/review_model.dart';
import 'package:furniture_app/state/review/review_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewNotifier extends ChangeNotifier {
  List<ReviewModel> reviewList = [];
  String get message => _message;

  String _message = '';

  Future<void> addReview(int idProduct,int order_id, String message, int rating,String uid)  async {
    _message = '';
    final response = await ReviewApi.addReview( idProduct,order_id, message, rating,uid);
    _message = response;
    notifyListeners();
  }
  Future<void> fetchReview(int idProduct) async {
    final response = await ReviewApi.getReview(idProduct);
    reviewList = response;
    notifyListeners();
  }
}



final productReviewsProvider = ChangeNotifierProvider(
  (ref) => ReviewNotifier(),
);