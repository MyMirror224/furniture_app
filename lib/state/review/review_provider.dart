import 'package:flutter/material.dart';
import 'package:furniture_app/model/review_model.dart';
import 'package:furniture_app/state/review/review_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewNotifier extends ChangeNotifier {
  List<ReviewModel> reviewList = [];
  Future<void> addReview(ReviewModel review)  async {
    final response = await ReviewApi.addReview(review);
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