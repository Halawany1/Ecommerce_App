
import 'package:dio/dio.dart';

class DioHelper{
  static Dio ?dio;
  static Init(){
    dio=Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response> GetData({
    required url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      if (token != null) 'Authorization': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> PostData({
    required url,
    required Map<String,dynamic> data,
    String lang='en',
    String ?token
  }) async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      if (token != null) 'Authorization': token,
    };
    return await dio!.post(url,data: data);
  }

  static Future<Response> PutData({
    required url,
    required Map<String,dynamic> data,
    String lang='en',
    String ?token
  }) async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      if (token != null) 'Authorization': token,
    };
    return await dio!.put(url,data: data);
  }
}