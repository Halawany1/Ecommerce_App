import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled/Network/remote/dio_helper.dart';

import '../../Network/end_points.dart';
import '../../models/user_model/User_Model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(AuthInitial());
  bool passwordVisibility=false;
  UserModel ?userModel;
  void ChangePasswordVisibility(){
    passwordVisibility=!passwordVisibility;
    emit(ChangePasswordVisibilityState());
  }

  void UserLogin(
  {
    required String email,
    required String password
}
      ){
    emit(LoadingLoginState());
    DioHelper.PostData(url: login, data:{
      'email':email,
      'password':password
    }).then((value) {
      userModel=UserModel.fromJson(value.data);

      print(userModel?.message);
      emit(LoginSuccessState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginFailedState(error: error));
    });
  }


  void UserSignUp(
      {
        required String email,
        required String password,
        required String name,
        required String phone,
      }
      ){
    emit(LoadingSignUpState());
    DioHelper.PostData(url: register
        , data:{
          'email':email,
          'password':password,
          'name':name,
          'phone':phone
        }).then((value) {
      userModel=UserModel.fromJson(value.data);
      emit(SignUpSuccessState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(SignUpFailedState(error: error));
    });
  }

  void GetUserData(){
    emit(LoadingUserDataState());
    DioHelper.GetData(url: profile
        ,token: token).
    then((value) {
      userModel=UserModel.fromJson(value.data);
      emit(SuccessUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorUserDataState(error.toString()));
    });
  }
  ChagePassModel ?chagePassModel;
  void ChangePasswordData({required String currentPass,required String newPass}){
    emit(LoadingChangePasswordDataState());
    DioHelper.PostData(
        url: changePassword
        ,token: token,
        data: {
      "current_password": currentPass,
      "new_password": newPass
        }).
    then((value) {
      chagePassModel=ChagePassModel.fromJson(value.data);
      emit(SuccessChangePasswordDataState(chagePassModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorChangePasswordDataState(error.toString()));
    });
  }

  void UpdateProfileData({ String ?name,String ?phone,String ?email}){
    emit(LoadingUpdateProfileDataState());
    DioHelper.PutData(
        url: updateProfile
        ,token: token,
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": "",
          "image": ""
        }).
    then((value) {
      userModel=UserModel.fromJson(value.data);
      emit(SuccessUpdateProfileDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdateProfileDataState(error.toString()));
    });
  }
}
