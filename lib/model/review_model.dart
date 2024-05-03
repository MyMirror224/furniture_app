import 'package:furniture_app/model/user_info_model.dart';

class ReviewModel {
  final int productId;
  final int orderId;
  final String comment;
  final int rating;
  final UserInfoModel user;

  ReviewModel({
    required this.user,
    required this.productId,
    required this.orderId,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      user: UserInfoModel.fromJson(json['user']),
      productId: json['product_id'],
      orderId: json['order_id'],
      comment: json['content'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['comment'] = comment;
    data['rating'] = rating;
    return data;
  }
}
