class ProductModel {
  final String? id;
  final String? productName;
  final String? image;
  final String? price;
  final String? description;
  final String? cateloryId;
  final String? promotionId;
  final String? rating;
  final String? quantity;
  final String? solded;
  final String? isShow;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.productName,
    required this.image,
    required this.price,
    required this.description,
    required this.cateloryId,
    required this.promotionId,
    required this.rating,
    required this.quantity,
    required this.solded,
    required this.isShow,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      productName: json['product_name'],
      image: json['product_image'],
      price: json['price'].toString(),
      description: json['description'],
      cateloryId: json['catelory_id'].toString(),
      promotionId: json['promotion_id'].toString(),
      rating: json['rating_count'].toString(),
      quantity: json['quantity'].toString(),
      solded: json['sold'].toString(),
      isShow: json['is_show'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_image': image,
      'price': price,
      'description': description,
      'catelory_id': cateloryId,
      'promotion_id': promotionId,
      'rating_count': rating,
      'quantity': quantity,
      'sold': solded,
      'is_show': isShow,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
