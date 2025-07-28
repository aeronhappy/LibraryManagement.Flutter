import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:library_management/features/authentication/model/auth_response_model.dart';
import 'package:library_management/features/authentication/model/request/login_request.dart';
import 'package:library_management/features/authentication/model/request/register_request.dart';
import 'package:library_management/features/authentication/model/role_model.dart';
import 'package:library_management/helper/api_provider.dart';

abstract class IAuthRemoteDatasource {
  Future<List<RoleModel>> getRoles();
  Future<AuthResponseModel> createAccount(RegisterRequest registerRequest);
  Future<AuthResponseModel> loginAccount(LoginRequest loginRequest);
}

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final APIProvider apiProvider;
  AuthRemoteDatasource({required this.apiProvider});

  @override
  Future<List<RoleModel>> getRoles() async {
    try {
      Response response = await apiProvider.client.get("/api/roles");

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<RoleModel>(
              (e) => RoleModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } on DioException catch (e) {
      log(e.response!.data.toString());
      return [];
    }
  }

  @override
  Future<AuthResponseModel> createAccount(
    RegisterRequest registerRequest,
  ) async {
    try {
      Response response = await apiProvider.client.post(
        "/api/authentication/register",
        data: registerRequest.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception("Failed to register account");
      }
    } on DioException catch (e) {
      log("CreateAccount Error: ${e.response?.data ?? e.message}");
      rethrow;
    }
  }

  @override
  Future<AuthResponseModel> loginAccount(LoginRequest loginRequest) async {
    try {
      Response response = await apiProvider.client.post(
        "/api/authentication/login",
        data: loginRequest.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception("Login failed");
      }
    } on DioException catch (e) {
      log("LoginAccount Error: ${e.response?.data ?? e.message}");
      rethrow;
    }
  }
}
