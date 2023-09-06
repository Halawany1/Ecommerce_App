import 'data.dart';

class HomeModel {
  bool ?status;
  String ?message;
  Data ?data;
  HomeModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}
