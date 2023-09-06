import 'Data.dart';

class CartModel {
  bool ?status;
  String ?message;
  Data ?data;

  CartModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}