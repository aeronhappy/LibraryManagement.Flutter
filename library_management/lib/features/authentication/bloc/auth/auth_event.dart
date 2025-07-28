part of 'auth_bloc.dart';

class AuthEvent {}

class RegisterAccount extends AuthEvent {
  final RegisterRequest registerRequest;
  RegisterAccount({required this.registerRequest});
}

class LoginAccount extends AuthEvent {
  final LoginRequest loginRequest;
  LoginAccount({required this.loginRequest});
}
