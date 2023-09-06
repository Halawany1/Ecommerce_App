part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class AuthInitial extends UserState {}

class ChangePasswordVisibilityState extends UserState {}

class LoadingLoginState extends UserState {}

class LoginSuccessState extends UserState {
  final UserModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginFailedState extends UserState {
  final String error;
  LoginFailedState({required this.error});
}

class LoadingSignUpState extends UserState {}

class SignUpSuccessState extends UserState {
  final UserModel signupmodel;
  SignUpSuccessState(this.signupmodel);
}

class SignUpFailedState extends UserState {
  final String error;
  SignUpFailedState({required this.error});
}

class LoadingUserDataState extends UserState {}

class SuccessUserDataState extends UserState {}

class ErrorUserDataState extends UserState {
  final String error;
  ErrorUserDataState(this.error);
}

class LoadingChangePasswordDataState extends UserState {}

class SuccessChangePasswordDataState extends UserState {
final ChagePassModel chagePassModel;
SuccessChangePasswordDataState(this.chagePassModel);
}

class ErrorChangePasswordDataState extends UserState {
  final String error;
  ErrorChangePasswordDataState(this.error);
}


class LoadingUpdateProfileDataState extends UserState {}

class SuccessUpdateProfileDataState extends UserState {
  final UserModel userModel;
  SuccessUpdateProfileDataState(this.userModel);
}

class ErrorUpdateProfileDataState extends UserState {
  final String error;
  ErrorUpdateProfileDataState(this.error);
}