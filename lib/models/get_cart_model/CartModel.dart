import 'Data.dart';

class GetCartModel {
  bool ?status;
  String ?message;
  Data ?data;

  GetCartModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}