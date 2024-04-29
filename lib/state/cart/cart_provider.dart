import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furniture_app/components/cartbottomnarbar.dart';
import 'package:furniture_app/model/cart_model.dart';
import 'package:furniture_app/model/product_model.dart';
import 'package:furniture_app/state/cart/cart_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartNotifier extends ChangeNotifier {
  CartModel get carts => _carts;
  CartModel _carts = CartModel();
  double get totalBefore => _totalBefore;
  double _totalBefore = 0;

  double get discount => _discount;
  double _discount = 0;
  String get message => _message;
  String _message = '';
  List<CartItemsSendOrder> get cartItems => _cartItems;
  List<CartItemsSendOrder> _cartItems = [];
  List<CartItems> get cartItemsShow => _cartItemsShow;
  List<CartItems> _cartItemsShow = [];
  String url = '';
  double totalSendBuy = 0;

  bool get isSelectPayPal => _isSelectPayPal;
  bool _isSelectPayPal = true;
  bool get isSelectVnPay => _isSelectVnPay;
  bool _isSelectVnPay = false;
  bool get isSelectDirect => _isSelectDirect;
  bool _isSelectDirect = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? messageController = '';

  void saveInfo(String name, String phone, String address, String? message) {
    nameController.text = name;
    phoneController.text = phone;
    addressController.text = address;
    if (message == "") {
      messageController = 'Không có ghi chú';
    } else {
      messageController = message;
    }

    notifyListeners();
  }

  void changSelectPayPal() {
    _isSelectPayPal = !_isSelectPayPal;
    _isSelectVnPay = false;
    _isSelectDirect = false;
    notifyListeners();
  }

  void changSelectVnPay() {
    _isSelectVnPay = !_isSelectVnPay;
    _isSelectPayPal = false;
    _isSelectDirect = false;
    notifyListeners();
  }

  void changSelectDirect() {
    _isSelectDirect = !_isSelectDirect;
    _isSelectVnPay = false;
    _isSelectPayPal = false;
    notifyListeners();
  }

  Future<void> totalnotDiscount() async {
    double sum = 0;
    _carts.products?.items?.forEach((element) {
      if (element.isSelected) {
        sum += (element.price! * element.quantity!.toDouble());
      }
    });
    _totalBefore = sum;
  }

  Future<void> fetchCart(String uid) async {
    try {
      final response = await CartApi.getCart(uid);
      _carts = response;
      totalnotDiscount();
      _discount = _totalBefore - _carts.products!.total!;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addtoCart(String uid, int quantity, int product_id) async {
    try {
      final response = await CartApi.cartAdd(uid, quantity, product_id);

      _message = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String uid, String product_id) async {
    try {
      _message = 'fail';
      print(uid + " abc " + product_id);
      final response = await CartApi.delete(uid, product_id);
      _message = response;
      if (_message != 'fail') {
        _carts.products?.items
            ?.removeWhere((element) => element.id == product_id);
        total();
        totalnotDiscount();
        _discount = _totalBefore - _carts.products!.total!;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> changQuantity(int index, int quantity, String uid) async {
    try {
      if (quantity == -1 && _carts.products!.items![index].quantity == 1) {
      } else {
        _carts.products!.items![index].quantity =
            _carts.products!.items![index].quantity! + quantity;
        await CartApi.update(uid, _carts.products!.items![index].quantity!,
            _carts.products!.items![index].id!);
        total();
        totalnotDiscount();
        _discount = _totalBefore - _carts.products!.total!;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> changSelect(int index, bool select) async {
    try {
      _carts.products!.items![index].isSelected = select;
      total();
      totalnotDiscount();
      _discount = _totalBefore - _carts.products!.total!;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> total() async {
    double sum = 0;
    for (var item in _carts.products!.items!) {
      if (item.isSelected) {
        sum += (item.discountPrice! * item.quantity!.toDouble());
      }
    }
    _carts.products!.total = sum;
    notifyListeners();
  }

  Future<void> sendItemBuy() async {
    int type;
    url = '';
    if (isSelectDirect) {
      type = 1;
    } else {
      if (isSelectPayPal) {
        type = 2;
      } else {
        type = 3;
      }
    }

    final respone = await CartApi.sendItemBuy(
        _carts.uid!.toString(),
        _cartItems,
        totalSendBuy,
        nameController.text,
        phoneController.text,
        addressController.text,
        messageController,
        type);
    url = respone;
    notifyListeners();
  }

  void saveCartItem() {
    _cartItemsShow = [];
    _cartItems = [];
    for (var item in _carts.products!.items!) {
      if (item.isSelected) {
        _cartItemsShow.add(item);
        CartItemsSendOrder cartItemsSendOrder = CartItemsSendOrder(
          id: item.id,
          quantity: item.quantity,
          price: item.discountPrice,
        );
        _cartItems.add(cartItemsSendOrder);
      }
    }
    totalSendBuy = _carts.products!.total!;
    notifyListeners();
  }

  Future<void> buyNowItem(ProductModel productModel, String quantity, double promotion, double total)  async {
    _cartItemsShow = [];
    _cartItems = [];
    print(total);
    int quantitySend = int.parse(quantity);
    final price =productModel.price!- productModel.price! * promotion/100;
    CartItemsSendOrder cartItemsSendOrder = CartItemsSendOrder(
      id: productModel.id.toString(),
      quantity: quantitySend,
      price: price ,
    );
    _cartItems.add(cartItemsSendOrder);
    CartItems cartItems = CartItems(
      id: productModel.id.toString(),
      name: productModel.productName,
      quantity: quantitySend,
      discountPrice: price,
    );
    _cartItemsShow.add(cartItems);
    totalSendBuy= total;
    notifyListeners();
  }
}

final cartProvider =
    ChangeNotifierProvider<CartNotifier>((ref) => CartNotifier());