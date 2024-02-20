import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/typedef/catelory.dart';

@immutable
class CateloryModel extends MapView<String, String?> {
  final String cateloryName;
  final String cateloryImage;

   CateloryModel(
     {
    required this.cateloryName,
    required this.cateloryImage,
  }): super(
    {
      FirebaseFieldName.cateloryName: cateloryName ,
      FirebaseFieldName.cateloryImage: cateloryImage,
    }
  );

  CateloryModel.fromJson(
    Map<String, dynamic> json, {
    required CateloryId cateloryId,
  }) : this(
   
    cateloryName: json[FirebaseFieldName.cateloryName] ?? '',
    cateloryImage: json[FirebaseFieldName.cateloryImage] ?? '',
  );
    

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
