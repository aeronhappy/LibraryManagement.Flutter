import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:library_management/features/Member/model/create_member_model.dart';
import 'package:library_management/features/Member/model/member_model.dart';
import 'package:library_management/helper/api_provider.dart';

abstract class IMemberRemoteDatasource {
  Future<List<MemberModel>> getMembers(String searchText);
  Future<MemberModel?> getMyMemberProfile();

  Future<MemberModel?> addMember(CreateMemberModel createMemberModel);
  Future<void> deleteMember(String memberId);
}

class MemberRemoteDatasource implements IMemberRemoteDatasource {
  final APIProvider apiProvider;
  MemberRemoteDatasource({required this.apiProvider});

  @override
  Future<List<MemberModel>> getMembers(String searchText) async {
    try {
      Response response = await apiProvider.client.get(
        "/api/members?searchText=$searchText",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<MemberModel>(
              (e) => MemberModel.fromJson(e as Map<String, dynamic>),
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
  Future<MemberModel?> getMyMemberProfile() async {
    try {
      Response response = await apiProvider.client.get("/api/members/me");

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return MemberModel.fromJson(data);
      }
      return null;
    } on DioException catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  @override
  Future<MemberModel?> addMember(CreateMemberModel createMemberModel) async {
    try {
      final response = await apiProvider.client.post(
        "/api/members",
        data: createMemberModel,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return MemberModel.fromJson(data);
      }
      return null;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
      return null;
    }
  }

  @override
  Future<void> deleteMember(String memberId) async {
    try {
      await apiProvider.client.delete("/api/members/$memberId");
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
    }
  }
}
