import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ProductAPI {
  static Future<List<ProductModel>> getProduct() async {
    try {
      final response = await HttpUtil().post(
        'api/products/all',
      );

      var productJson = response['products'] as List;
      var products = productJson.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    } catch (e) {
      print(e);
      throw Exception('Failed to load product');
    }
  }
}
