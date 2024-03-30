// import 'dart:convert';

// import 'package:furniture_app/models/product/product.dart';
// import 'package:furniture_app/services/constain.dart';
// import 'package:http/http.dart' as http;

// Future<List<Product>> futureProductsSearching(String keySearch) async {
//   http.Response response =
//       await http.get(Uri.parse('$baseUrl/api/product/search/$keySearch'));
//   if (response.statusCode == 200) {
//     List<Product> res = <Product>[];
//     for (var i in json.decode(response.body)) res.add(Product.fromJson(i));
//     return res;
//   } else {
//     throw Exception('Failed to load');
//   }
// }
