import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/typedef/catelory.dart';

@immutable
class CateloryModel  {
  final String? cateloryName;
  final String? cateloryImage;

  const CateloryModel({
    required this.cateloryName,
    required this.cateloryImage,
  });

  factory CateloryModel.fromJson(Map<String, dynamic> json) {
    return CateloryModel(
      cateloryName: json['name'],
      cateloryImage: json['image'],
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CateloryModel &&
          runtimeType == other.runtimeType &&
          cateloryName == other.cateloryName &&
          cateloryImage == other.cateloryImage;
  @override
  int get hashCode => Object.hash(cateloryName, cateloryImage);
}
