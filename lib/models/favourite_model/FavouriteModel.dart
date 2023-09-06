import 'Data.dart';

class FavouriteModel {
  bool ?status;
  String ?message;
  Data ?data;
  FavouriteModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }



}