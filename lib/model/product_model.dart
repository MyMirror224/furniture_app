class ProductModel {
  final int? id;
  final String? productName;
  final List<String>? image;
  final double? price;
  final String? description;
  final String? cateloryId;
  final int? promotion;
  final double? rating;
  final int? quantity;
  final int? solded;
  final bool? isShow;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? color;

  ProductModel({
    required this.id,
    required this.productName,
    required this.image,
    required this.price,
    required this.description,
    required this.cateloryId,
    required this.promotion,
    required this.rating,
    required this.quantity,
    required this.solded,
    required this.isShow,
    required this.color,

    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      color: json['color'],
      productName: json['product_name'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'],
      cateloryId: json['catelory_id'].toString(),
      promotion: json['discount'],
      rating: double.tryParse(json['rating_count'].toString()) ?? 5.0,
      quantity: json['quantity'],
      solded: json['sold'],
      isShow: json['is_show'] == 1 ? true : false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      image: List<String>.from(
          json['product_image']?.map((item) => item.toString()) ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'description': description,
      'catelory_id': cateloryId,
      'discount': promotion,
      'rating_count': rating,
      'quantity': quantity,
      'sold': solded,
      'color': color,
      'is_show': isShow,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product_image': image,
    };
  }
}
