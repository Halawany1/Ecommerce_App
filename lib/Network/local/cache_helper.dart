import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences ?sharedPreferences;
  static Init() async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static dynamic GetData({
    required String key,
    required dynamic value
}){

    return sharedPreferences!.get(key);
  }
  static  Future<bool?> SaveData({
    required String key,
    required  dynamic value,
  })async{
    if(value is bool)return await sharedPreferences!.setBool(key, value);
    if(value is String)return await sharedPreferences!.setString(key, value);
    if(value is double)return await sharedPreferences!.setDouble(key, value );
    if(value is int)return await sharedPreferences!.setInt(key, value);
  }

  static Future<bool?> DeletAllData() async{
    return await sharedPreferences!.clear();
  }
  static Future<bool?>  RemoveData({required String key}) async{
    return   await sharedPreferences!.remove(key);
  }
}