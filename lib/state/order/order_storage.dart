import 'package:furniture_app/service/http_util.dart';
import 'package:furniture_app/model/order_model.dart';

class OrderApi {
  static Future<List<OrderModel>> getModel(String uid) async {
    try {
      final response = await HttpUtil().post(
        'api/orders/all',
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
  
}
