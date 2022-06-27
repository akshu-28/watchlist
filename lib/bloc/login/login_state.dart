part of 'login_bloc.dart';


abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoad extends LoginState {}

class LoginDone extends LoginState {
  final LoginResponse response;

  LoginDone(this.response);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}
