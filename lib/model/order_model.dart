import 'package:furniture_app/model/cart_model.dart';

class OrderModel {
  final String id;
  final String uid;
  final String name;
  final List<ProductInOrder> products;
  final String? address;
  final String? phone_number;
  final String type;
  final String note;
  final int status;
  final double total_price;
  final int is_done;

  OrderModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.products,
    required this.total_price,
    required this.address,
    required this.type,
    required this.phone_number,
    required this.note,
    required this.status,
    required this.is_done,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      uid: json['user_id'],
      type: json['type_payment'],
      name: json['name'],
      total_price: json['total_price'],
      products: List<ProductInOrder>.from(json['products'].map((x) => ProductInOrder.fromJson(x))),
      address: json['address'],
      phone_number: json['phone'],
      note: json['note'],
      status: json['status'],
      is_done: json['is_done'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['products'] = products.map((v) => v.toJson()).toList();
    data['address'] = address;
    data['phone_number'] = phone_number;
    data['note'] = note;
    data['status'] = status;
    data['is_done'] = is_done;
    data['total_price'] = total_price;
    data['type_payment'] = type;

    return data;
  }
}

class ProductInOrder {
  final String? product_id;
  final String? name;
  final double? price;
  final int? quantity;
  final String image;

  ProductInOrder(
      {this.product_id,
      this.name,
      this.price,
      this.quantity,
      required this.image});

  factory ProductInOrder.fromJson(Map<String, dynamic> json) {
    return ProductInOrder(
      product_id: json['product_id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'name': name,
        'price': price,
        'quantity': quantity,
        'image': image
      };
}

class OrderShowUi {
  final String? product_id;
  final String? nameProduct;
  final double? price;
  final int? quantity;
  final String image;
  final String id;
  final String uid;
  final String name;
  final String? address;
  final String? phone_number;
  final String type;
  final String note;
  final int status;
  final double total_price;
  final int is_done;

  const OrderShowUi({
    required this.product_id,
    required this.nameProduct,
    required this.price,
    required this.quantity,
    required this.image,
    required this.id,
    required this.uid,
    required this.name,
    required this.address,
    required this.phone_number,
    required this.type,
    required this.note,
    required this.status,
    required this.total_price,
    required this.is_done,
  });
}
