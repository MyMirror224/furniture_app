import 'package:furniture_app/model/category_model.dart';
import 'package:furniture_app/service/http_util.dart';

class CategoriesAPI {
  static Future<List<CategoryModel?>> getCatelory(int id_category) async {
    try {
      final response = await HttpUtil().post(
        'api/categories/show/' + id_category.toString(),
      );
      final categories = response['categories']
          .map<CategoryModel?>((category) => CategoryModel.fromJson(category))
          .toList();

      return categories;
    } catch (e) {
      print(e);
      throw Exception('Failed to load category');
    }
  }
}
