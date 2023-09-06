import 'Data.dart';

class Categories {
  bool ?status;
  String ?message;
  Data ?data;

  Categories.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}