import 'dart:async';
import 'dart:convert';

import 'package:furniture_app/service/http_util.dart';
import 'package:furniture_app/state/catelory/catelory_model.dart';

class CategoriesAPI {
  static Future<CateloryModel?> getCatelory() async {
    try {
      final response = await HttpUtil()
          .get('api/categories/all');
       final  result = jsonDecode( response);
        print('abc');
        
        return result.data as CateloryModel;
     
    } catch (e) {
      if (e is TimeoutException) {
        print('timed out');
        return null; // đây là lỗi khi kết nối mạng bị gián đoạn hoặc không ổn định
      }
      throw Exception('Failed to load catelory');
    }
  }
}
