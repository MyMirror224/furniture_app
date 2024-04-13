
class CartModel {
  int? uid;
  ProductsInCart? products;

  CartModel({this.uid, this.products});

  CartModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    products = json['products'] != null
        ?  ProductsInCart.fromJson(json['products'])
        : null;
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
  double? subtotal;
  double? total;

  ProductsInCart({this.items, this.totalItems, this.subtotal, this.total});

  ProductsInCart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CartItems>[];
      json['items'].forEach((v) {
        items!.add( CartItems.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    subtotal = json['subtotal'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = totalItems;
    data['subtotal'] = subtotal;
    data['total'] = total;
    return data;
  }
}

class CartItems {
  String? id;
  String? name;
  double? price;
  String? image;
  int? quantity;

  CartItems({this.id, this.name, this.price, this.image, this.quantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['quantity'] = quantity;
    return data;
  }
}

