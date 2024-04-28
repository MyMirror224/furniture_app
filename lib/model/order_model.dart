import 'package:furniture_app/model/cart_model.dart';

class OrderModel {
  final String id;
  final String uid;
  final String name;
  final ProductsInCart products;
  final String? address;
  final String? phone_number;
  final String note;
  final int status;
  final bool is_done;
  final String email;

  OrderModel(  {
    required this.id,
    required this.uid,
    required this.name,
    required this.products,
    required this.address,
    required this.phone_number,
    required this.note,
    required this.status,
    required this.is_done,
    required this.email
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      products: ProductsInCart.fromJson(json['products']),
      address: json['address'],
      phone_number: json['phone_number'],
      note: json['note'],
      status: json['status'],
      is_done: json['is_done'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() { 
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['products'] = products.toJson();
    data['address'] = address;
    data['phone_number'] = phone_number;
    data['note'] = note;
    data['status'] = status;
    data['is_done'] = is_done;
    data['email'] = email;
    return data;
  }

}