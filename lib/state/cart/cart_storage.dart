import 'package:furniture_app/model/cart_model.dart';
import 'package:furniture_app/service/http_util.dart';

class CartApi{
  static Future<CartModel> getCart() async {
    try {
      final response = await HttpUtil().post(
        'api/cart',
      );
      var cartJson = response['carts'];
      final CartModel carts = CartModel.fromJson(cartJson);
      
      return carts;
    } catch (e) {
      print(e);
      throw Exception('Failed to load cart');
    }
  }

}