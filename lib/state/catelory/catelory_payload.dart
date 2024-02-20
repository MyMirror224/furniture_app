import 'dart:collection';

import 'package:furniture_app/constant/firebase_field_name.dart';

class CateloryPayload extends MapView<String, String?> {
  
  final String cateloryName;
  final String cateloryImage;
   CateloryPayload({
    required this.cateloryName,
    required this.cateloryImage,
  }): super(
    {
      FirebaseFieldName.cateloryName: cateloryName,
      FirebaseFieldName.cateloryImage: cateloryImage ,
    }
  );
}