import 'package:furniture_app/model/review_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ReviewApi {
  static Future<List<ReviewModel>> getReview(int idProduct) async {
    List<ReviewModel> reviewList = [];
    final response = await HttpUtil().post(
      'api/reviews/all',
      queryParameters: { 'id_product': idProduct },
    );
    reviewList = List<ReviewModel>.from(response['reviews'].map((x) => ReviewModel.fromJson(x)));
    return reviewList;
  }
  static Future<String> addReview(ReviewModel review) async {
    
    final response = await HttpUtil().post(
      'api/reviews/add',
      queryParameters: review.toJson()
    );
    return response['message'];
  }
}