import 'Product.dart';

class CartItems {
  int ?id;
  dynamic quantity;
  Product ?product;
  CartItems.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }



}