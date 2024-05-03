import 'package:furniture_app/service/http_util.dart';
import 'package:furniture_app/model/order_model.dart';

class OrderApi {
  static Future<List<OrderModel>> getModel(String uid) async {
    try {
      final response = await HttpUtil().post(
        'api/orders/allByUid',
        queryParameters: {
      'uid': uid,
        },
      );
      return List<OrderModel>.from(response['data'].map((x) => OrderModel.fromJson(x)));
    } catch (e) {
      print(e);
      throw Exception('Failed to load product');
    }
  }

  static Future<String> cancelOrder(int id ,String message) async {
    final response = await HttpUtil().post(
      'api/orders/cancel',
      queryParameters: {
        'order_id': id,
        'reason': message,
      },
    );
    return response['message'];
}
 static Future<String> refundOrder(int id,String message) async {
    final response = await HttpUtil().post(
      'api/orders/refund',
      queryParameters: {
        'order_id': id,
        'reason': message,
      },
    );
    return response['message'];
}
}