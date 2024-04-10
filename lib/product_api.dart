import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ProductApi {
  static Future<ProductEntity> getProducts() async {
    var response = await HttpUthtil().post(
      'api/products',
    );
    return ProductEntity.fromJson(response);
  }
}

class ProductEntity {
  String? code;
  String? message;
  ProductModel? data;

  ProductEntity({this.code, this.message, this.data});
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      code: json['code'],
      message: json['message'],
      data: ProductModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
