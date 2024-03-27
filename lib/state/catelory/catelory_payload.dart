import 'dart:collection';

import 'package:furniture_app/constant/firebase_field_name.dart';

class CateloryPayload extends MapView<String, String?> {
  final String cateloryName;
  final String cateloryImage;
  CateloryPayload({
    required this.cateloryName,
    required this.cateloryImage,
  }) : super({
          DataBaseName.cateloryName: cateloryName,
          DataBaseName.cateloryImage: cateloryImage,
        });
}
