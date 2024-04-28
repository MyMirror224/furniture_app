import 'package:furniture_app/model/product_model.dart';

extension ProductExtension on List<ProductModel?> {
  List<ProductModel?> filterByPrice(double minPrice, double maxPrice) {
    return where((product) =>
        product!.price! >= minPrice && product.price! <= maxPrice).toList();
  }

  List<ProductModel?> filterByCategory(String categoryId) {
    return where((product) => product!.categoryId == categoryId).toList();
  }

  List<ProductModel?> filterByRating(double minRating) {
    return where((product) => product!.rating! >= minRating).toList();
  }

  List<ProductModel?> filterByIsShow(bool isShow) {
    return where((product) => product!.isShow == isShow).toList();
  }

  List<ProductModel?> getTopSellingProducts(int limit) {
    // Sắp xếp danh sách theo số lượng sản phẩm đã bán (solded) giảm dần
    final sortedProducts = [...this]
      ..sort((a, b) => b!.solded!.compareTo(a!.solded!));

    // Lấy ra `limit` sản phẩm đầu tiên từ danh sách đã sắp xếp
    return sortedProducts.take(limit).toList();
  }
}
