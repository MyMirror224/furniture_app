import 'package:flutter/foundation.dart';

@immutable
class CategoryModel {
  final String? cateloryId;
  final String? cateloryName;
  final String? cateloryImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.cateloryImage,
    required this.cateloryName,
    required this.cateloryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      cateloryName: json['name'],
      cateloryId:
          json['id'].toString(), // nhớ nha MINH NHẬT nhớ đổi về kiểu STRING
      cateloryImage: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": cateloryId,
        "name": cateloryName,
        "image": cateloryImage,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          cateloryId == other.cateloryId &&
          cateloryName == other.cateloryName &&
          cateloryImage == other.cateloryImage;

  @override
  int get hashCode => Object.hash(cateloryName, cateloryImage);
}
