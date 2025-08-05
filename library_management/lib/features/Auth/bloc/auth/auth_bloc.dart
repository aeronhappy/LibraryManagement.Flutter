import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:library_management/features/Auth/datasource/auth_remote_datasource.dart';
import 'package:library_management/features/Auth/model/auth_response_model.dart';
import 'package:library_management/features/Auth/model/request/login_request.dart';
import 'package:library_management/features/Auth/model/request/register_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRemoteDatasource authRemoteDatasource;
  final SharedPreferences sharedPreferences;
  AuthBloc({
    required this.authRemoteDatasource,
    required this.sharedPreferences,
  }) : super(AuthBlocInitial()) {
    on<RegisterAccount>((event, emit) async {
      try {
        emit(LoadingAuth());
        AuthResponseModel authResponse = await authRemoteDatasource
            .createAccount(event.registerRequest);

        if (authResponse.isSuccess) {
          emit(SuccessAuth(authResponseModel: authResponse));
          sharedPreferences.setString("MY_TOKEN", authResponse.accessToken!);
          log(authResponse.accessToken!);
          return;
        }

        emit(FailedAuth(message: authResponse.message!));
      } catch (e) {
        emit(FailedAuth(message: e.toString()));
      }
    });

    on<LoginAccount>((event, emit) async {
      try {
        emit(LoadingAuth());
        AuthResponseModel authResponse = await authRemoteDatasource
            .loginAccount(event.loginRequest);

        if (authResponse.isSuccess) {
          emit(SuccessAuth(authResponseModel: authResponse));
          sharedPreferences.setString("MY_TOKEN", authResponse.accessToken!);
          log(authResponse.accessToken!);
          return;
        }

        emit(FailedAuth(message: authResponse.message!));
      } catch (e) {
        emit(FailedAuth(message: e.toString()));
      }
    });
  }
}
