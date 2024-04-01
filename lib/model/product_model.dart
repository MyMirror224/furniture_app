class ProductModel {
  final int? id;
  final String? productName;
  final List<String>? images;
  final double? price;
  final String? description;
  final String? cateloryId;
  final int? promotionId;
  final double? rating;
  final int? quantity;
  final int? solded;
  final bool? isShow;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.productName,
    required this.images,
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
      id: json['id'],
      productName: json['product_name'],
      images: json['product_image'],
      price: json['price'],
      description: json['description'],
      cateloryId: json['catelory_id'].toString(),
      promotionId: json['promotion_id'],
      rating: json['rating_count'],
      quantity: json['quantity'],
      solded: json['sold'],
      isShow: json['is_show'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_image': images,
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
