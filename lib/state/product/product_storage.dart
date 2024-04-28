import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/service/http_util.dart';

class ProductAPI {
  static Future<List<ProductModel>> getProduct() async {
    try {
      final response = await HttpUtil().post(
        'api/products/all',
      );

      var productJson = response['products'];

      final List<ProductModel> products = List<ProductModel>.from(
          productJson.map((x) => ProductModel.fromJson(x)));

      return products;
    } catch (e) {
      print(e);
      throw Exception('Failed to load product');
    }
  }
  static Future<List<ProductModel>> getProductwithIdCategory(int? id, String? name, double? rating, double? minPrice, double? maxPrice, String? type) async {
    try {
      
      final response = await HttpUtil().post(
        'api/products/search',
        queryParameters:  {
          'category_id': id,
          'product_name': name,
          'rating_count': rating,
          'price_min': minPrice,
          'price_max': maxPrice,
          'type' : type 
        }
      );
      
      var productJson = response['products'] ;
      
      final List<ProductModel> products = List<ProductModel>.from(
          productJson.map((x) => ProductModel.fromJson(x)));

      return products;
    } catch (e) {
      
      return  [];
     
      
    }
  }
  

}
