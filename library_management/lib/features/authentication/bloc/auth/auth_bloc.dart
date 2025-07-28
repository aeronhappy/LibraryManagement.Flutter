import 'package:bloc/bloc.dart';
import 'package:library_management/features/authentication/datasource/auth_remote_datasource.dart';
import 'package:library_management/features/authentication/model/auth_response_model.dart';
import 'package:library_management/features/authentication/model/request/login_request.dart';
import 'package:library_management/features/authentication/model/request/register_request.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthBloc({required this.authRemoteDatasource}) : super(AuthBlocInitial()) {
    on<RegisterAccount>((event, emit) async {
      try {
        AuthResponseModel authResponse = await authRemoteDatasource
            .createAccount(event.registerRequest);

        if (authResponse.isSuccess) {
          emit(AccountCreated(authResponseModel: authResponse));
          return;
        }

        FailedAuth(message: authResponse.message!);
      } catch (e) {
        FailedAuth(message: e.toString());
      }
    });

    on<LoginAccount>((event, emit) async {
      try {
        AuthResponseModel authResponse = await authRemoteDatasource
            .loginAccount(event.loginRequest);

        if (authResponse.isSuccess) {
          emit(SuccessLogin(authResponseModel: authResponse));
          return;
        }

        FailedAuth(message: authResponse.message!);
      } catch (e) {
        FailedAuth(message: e.toString());
      }
    });
  }
}
