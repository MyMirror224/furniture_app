import 'dart:convert';

import 'package:furniture_app/model/cart_model.dart';
import 'package:furniture_app/service/http_util.dart';

class CartApi {
  static Future<dynamic> sendItemBuy(
      String uid,
      List<CartItemsSendOrder> items,
      double total,
      String name,
      String phone,
      String address,
      String? message,
      int type) async {
    try {
      print(items.first.price);

      String jsonString =
          jsonEncode(items.map((item) => item.toJson()).toList());
      String url = '';
      if (type == 1) {
        final response = await HttpUtil().post(
          'api/payment-direct',
          queryParameters: {
            'uid': uid,
            'products': jsonString,
            'total_price': total,
            'address': address,
            'note': message,
            'phone': phone,
            'name': name,
          },
        );

        return response;
      }
      if (type == 2) {
        final response = await HttpUtil().post(
          'api/checkout',
          queryParameters: {
            'uid': uid,
            'products': jsonString,
            'total_price': total,
            'address': address,
            'note': message,
            'phone': phone,
            'name': name,
          },
        );
        url = response['data'] as String;
        return url;
      }
      if (type == 3) {
        final response = await HttpUtil().post(
          'api/payment-vnpay',
          queryParameters: {
            'uid': uid,
            'products': jsonString,
            'total_price': total,
            'address': address,
            'note': message,
            'phone': phone,
            'name': name,
          },
        );
        url = response['data'] as String;
        return url;
      }
    } catch (e) {
      return 'failed';
    }
  }

  static Future<CartModel> getCart(String uid) async {
    try {
      final userId = uid.toString();
      print('userId: ' + userId);
      final response =
          await HttpUtil().post('api/carts/show', queryParameters: {
        'uid': userId,
      });
      if (response['message'] == 'Chưa có sản phẩm') {
        return CartModel(
          uid: uid,
          products: ProductsInCart(
            totalItems: 0,
            total: 0.0,
            items: [],
          ),
        );
      }
      final cart = response['Cart'];
      final products = cart['products'];

      return CartModel(
        uid: uid,
        products: ProductsInCart(
          items: products['items'].map<CartItems>((item) {
            return CartItems(
              id: item['id'],
              name: item['name'],
              price: double.parse(item['price']),
              quantity: item['quantity'],
              image: item['image'],
              discountPrice: item['dicountPrice'] / 1.0,
              isSelected: true,
            );
          }).toList(),
          totalItems: products['totalItems'],
          total: products['total'] / 1.0,
        ),
      );
    } catch (e) {
      return CartModel();
    }
  }

  static Future<String> cartAdd(String uid, int quantity, int product) async {
    try {
      print(uid);
      final response = await HttpUtil().post(
        'api/carts/add',
        queryParameters: {
          'uid': uid,
          'quantity': quantity,
          'products_id': product,
        },
      );
      String mess = response['message'];

      return mess;
    } catch (e) {
      return 'error';
      throw Exception('Failed to load cart');
    }
  }

  static Future<String> delete(String uid, String product) async {
    try {
      final response = await HttpUtil().post(
        'api/carts/delete',
        queryParameters: {
          'uid': uid,
          'product_id': product,
        },
      );
      String mess = response['message'];

      return mess;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> update(String uid, int quantity, String product) async {
    try {
      final response = await HttpUtil().post(
        'api/carts/update',
        queryParameters: {
          'uid': uid,
          'quantity': quantity,
          'product_id': product,
        },
      );
      String mess = response['message'];

      return mess;
    } catch (e) {
      return 'error';
    }
  }
}
