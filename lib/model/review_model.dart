class ReviewModel {
  final String productId;
  final String orderId;
  final String uid;
  final String name;
  final String comment;
  final double rating;

  ReviewModel({
    
    required this.uid,
    required this.name,
    required this.productId,
    required this.orderId,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      uid: json['uid'],
      name: json['name'],
      productId: json['product_id'],
      orderId: json['order_id'],
      comment: json['comment'],
      rating: json['rating'],
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['comment'] = comment;
    data['rating'] = rating;
    return data;
  }
}