import 'package:furniture_app/model/category_model.dart';

class CategoryResponseEntity {
  int? code;
  String? msg;
  List<CategoryModel?>? data;

  CategoryResponseEntity({
    this.code,
    this.msg,
    this.data,
  });
  factory CategoryResponseEntity.fromJson(Map<String, dynamic> json) =>
      CategoryResponseEntity(
        code: json["code"],
        msg: json["message"],
        data: json["categories"]
            .map<CategoryModel?>((category) => CategoryModel.fromJson(category))
            .toList(),
      );
}
