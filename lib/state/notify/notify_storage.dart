import 'package:furniture_app/model/notify_model.dart';

import 'package:furniture_app/service/http_util.dart';

class NotifyApi {
  static  Future<List<NotificationModel>> getNotify(String uid) async {
    try {
      final response = await HttpUtil().post(
        'api/notifications/show',
        queryParameters: {
        'uid': uid,
        },
      );
      return List<NotificationModel>.from(response['data'].map((x) => NotificationModel.fromJson(x)));
    } catch (e) {
      print(e);
      throw Exception('Failed to load product');
    }
  }
  static  Future<List<NotificationModel>> update(int id,String uid , int type) async {
    try {
      final response = await HttpUtil().post(
        'api/notifications/update',
        queryParameters: {
        'id': id,
        'uid': uid,
        'type': type,
        },
      );
      return List<NotificationModel>.from(response['data'].map((x) => NotificationModel.fromJson(x)));
    } catch (e) {
      print(e);
      throw Exception('Failed to load product');
    }
  }
}