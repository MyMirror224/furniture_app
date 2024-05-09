import 'package:furniture_app/model/review_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ReviewApi {
  static Future<List<ReviewModel>> getReview(int idProduct) async {
    List<ReviewModel> reviewList = [];
    final response = await HttpUtil().post(
      'api/comments/show',
      queryParameters: {'product_id': idProduct},
    );
    String? message = response['message'] ?? "";
    if (message != 'No comments found') {
      reviewList = List<ReviewModel>.from(
          response['data'].map((x) => ReviewModel.fromJson(x)));
    }

    return reviewList;
  }

  static Future<String> addReview(int idProduct, int order_id, String message,
      int rating, String uid) async {
    final response =
        await HttpUtil().post('api/comments/create', queryParameters: {
      'product_id': idProduct,
      'order_id': order_id,
      'content': message,
      'rating': rating,
      'user_id': uid
    });
    return response['message'];
  }
}
