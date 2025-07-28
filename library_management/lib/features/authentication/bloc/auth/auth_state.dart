part of 'auth_bloc.dart';

class AuthState {}

class AuthBlocInitial extends AuthState {}

class LoadingAuth extends AuthState {}

class FailedAuth extends AuthState {
  final String message;
  FailedAuth({required this.message});
}

class AccountCreated extends AuthState {
  AuthResponseModel authResponseModel;
  AccountCreated({required this.authResponseModel});
}

class SuccessLogin extends AuthState {
  AuthResponseModel authResponseModel;
  SuccessLogin({required this.authResponseModel});
}
