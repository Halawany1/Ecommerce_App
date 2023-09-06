import 'CartItems.dart';

class Data {
  List<CartItems> ?cartItems;
  dynamic subTotal;
  dynamic total;
  Data.fromJson(Map<String,dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }


}