import 'Banners.dart';
import 'Products.dart';

class Data {

  List<Banners> ?banners;
  List<Products> ?products;
  String ?ad;

  Data.fromJson(Map<String,dynamic> json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }




}