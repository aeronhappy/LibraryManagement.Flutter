part of 'auth_bloc.dart';

class AuthState {}

class AuthBlocInitial extends AuthState {}

class LoadingAuth extends AuthState {}

class FailedAuth extends AuthState {
  final String message;
  FailedAuth({required this.message});
}

class SuccessAuth extends AuthState {
  AuthResponseModel authResponseModel;
  SuccessAuth({required this.authResponseModel});
}
