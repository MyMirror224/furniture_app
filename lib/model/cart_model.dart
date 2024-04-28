
class CartModel {
  String? uid;
  ProductsInCart? products;

  CartModel({this.uid, this.products});

  CartModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    if (products != null) {
      data['products'] = products!.toJson();
    }
    return data;
  }
}

class ProductsInCart {
  List<CartItems>? items;
  int? totalItems;
  
  double? total;

  ProductsInCart({this.items, this.totalItems, this.total});

  ProductsInCart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CartItems>[];
      json['items'].forEach((v) {
        items!.add( CartItems.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
   
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = totalItems;
   
    data['total'] = total;
    return data;
  }
}

class CartItems {
  String? id;
  String? name;
  double? price;
  bool isSelected = true;
  double? discountPrice;
  String? image;
  int? quantity;

  CartItems({ this.id, this.name, this.price, this.image, this.quantity, this.discountPrice, this.isSelected = true});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.tryParse(json['price'].toString()) ?? 0.0;
    image = json['image'];
    discountPrice = double.tryParse(json['discountPrice'].toString()) ?? 0.0;
    quantity = json['quantity'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['discountPrice'] = discountPrice;
    data['quantity'] = quantity;
    data['isSelected'] = isSelected;
    return data;
  }
}

class CartItemsSendOrder {
  String? id;
  int? quantity;
  double? price;
  CartItemsSendOrder({ this.id, this.quantity , this.price});

  CartItemsSendOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() => {
    'product_id': id,
    'quantity': quantity,
    'price': price
  };
}