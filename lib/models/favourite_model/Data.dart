import 'Product.dart';

class Data {
  int ?id;
  Product ?product;
  Data.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }


}