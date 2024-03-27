class ProductModel {
  final String id;
  final String productName;
  final List<String> image;
  final String price;
  final String description;
  final String cateloryId;
  final String promotionId;
  final int rating;
  final int quantity;
  final int solded;
  final bool isShow;

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
  });
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['product_name'],
      image: json['product_image'],
      price: json['price'],
      description: json['description'],
      cateloryId: json['catelory_id'],
      promotionId: json['promotion_id'],
      rating: json['rating_count'],
      quantity: json['quantity'],
      solded: json['sold'],
      isShow: json['is_show'],
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

    };
  }
  }