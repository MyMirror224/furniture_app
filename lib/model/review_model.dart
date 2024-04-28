class ReviewModel {
  final String userName;
  final String userImageUrl;
  final int rating;
  final String reviewText;

  ReviewModel({
    required this.userName,
    required this.userImageUrl,
    required this.rating,
    required this.reviewText,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['user_name'],
      userImageUrl: json['user_image_url'],
      rating: json['rating'],
      reviewText: json['review_text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['user_image_url'] = userImageUrl;
    data['rating'] = rating;
    data['review_text'] = reviewText;
    return data;
  }
  
  
}