import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:library_management/features/BorrowingRecord/model/borrowing_record_model.dart';
import 'package:library_management/helper/api_provider.dart';

abstract class IBorrowingRemoteDatasource {
  Future<List<BorrowingRecordModel>> getAllRecords(
    String searchText,
    DateTime? dateTime,
  );
  Future<List<BorrowingRecordModel>> getUnreturnedRecords(
    String searchText,
    DateTime? dateTime,
  );
  Future<List<BorrowingRecordModel>> getReturnedRecords(
    String searchText,
    DateTime? dateTime,
  );

  Future<void> borrowBook(String memberId, String bookId);
  Future<void> returnBook(String memberId, String bookId);
}

class BorrowingRemoteDatasource implements IBorrowingRemoteDatasource {
  final APIProvider apiProvider;
  BorrowingRemoteDatasource({required this.apiProvider});

  @override
  Future<void> borrowBook(String memberId, String bookId) async {
    try {
      await apiProvider.client.post(
        "/api/borrowings/$bookId/borrow?borrowerId=$memberId",
      );
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
    }
  }

  @override
  Future<void> returnBook(String memberId, String bookId) async {
    try {
      await apiProvider.client.post(
        "/api/borrowings/$bookId/return?borrowerId=$memberId",
      );
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
    }
  }

  @override
  Future<List<BorrowingRecordModel>> getAllRecords(
    String searchText,
    DateTime? dateTime,
  ) async {
    try {
      String dates = dateTime != null ? "&dateTime=$dateTime" : "";
      Response response = await apiProvider.client.get(
        "/api/borrowings/records?searchText=$searchText$dates",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<BorrowingRecordModel>(
              (e) => BorrowingRecordModel.fromJson(e as Map<String, dynamic>),
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
  Future<List<BorrowingRecordModel>> getUnreturnedRecords(
    String searchText,
    DateTime? dateTime,
  ) async {
    try {
      String dates = dateTime != null ? "&dateTime=$dateTime" : "";
      Response response = await apiProvider.client.get(
        "/api/borrowings/records/unreturned?searchText=$searchText$dates",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<BorrowingRecordModel>(
              (e) => BorrowingRecordModel.fromJson(e as Map<String, dynamic>),
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
  Future<List<BorrowingRecordModel>> getReturnedRecords(
    String searchText,
    DateTime? dateTime,
  ) async {
    try {
      String dates = dateTime != null ? "&dateTime=$dateTime" : "";
      Response response = await apiProvider.client.get(
        "/api/borrowings/records/returned?searchText=$searchText$dates",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<BorrowingRecordModel>(
              (e) => BorrowingRecordModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } on DioException catch (e) {
      log(e.response!.data.toString());
      return [];
    }
  }
}
