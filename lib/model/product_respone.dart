import 'package:furniture_app/model/product_model.dart';

class ProductResponse {
  List<ProductModel?>? data;
  int? code;
  String? msg;

  ProductResponse({
    this.data,
    this.code,
    this.msg,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
        code: json["code"],
        msg: json["message"],
      );
}
