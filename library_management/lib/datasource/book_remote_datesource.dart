import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:library_management/helper/api_provider.dart';
import 'package:library_management/model/book_model.dart';

abstract class IBookRemoteDatasource {
  Future<List<BookModel>> getBooks(String searchText);
  Future<List<BookModel>> getAvailableBooks(String searchText);
  Future<List<BookModel>> getOverdueBooks(String searchText);

  Future<BookModel?> addBook(String title, String author, String isbn);
  Future<void> deleteBook(String bookId);

  Future<void> borrowBook(String memberId, String bookId);

  Future<void> returnBook(String memberId, String bookId);
}

class BookRemoteDatasource implements IBookRemoteDatasource {
  final APIProvider apiProvider;
  BookRemoteDatasource({required this.apiProvider});

  @override
  Future<List<BookModel>> getBooks(String searchText) async {
    try {
      Response response = await apiProvider.client.get(
        "/api/books?searchText=$searchText",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<BookModel>(
              (e) => BookModel.fromJson(e as Map<String, dynamic>),
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
  Future<List<BookModel>> getAvailableBooks(String searchText) async {
    try {
      Response response = await apiProvider.client.get(
        "/api/books/available?searchText=$searchText",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<BookModel>(
              (e) => BookModel.fromJson(e as Map<String, dynamic>),
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
  Future<List<BookModel>> getOverdueBooks(String searchText) async {
    try {
      Response response = await apiProvider.client.get(
        "/api/books/overdue?searchText=$searchText",
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map<BookModel>(
              (e) => BookModel.fromJson(e as Map<String, dynamic>),
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
  Future<BookModel?> addBook(String title, String author, String isbn) async {
    try {
      final response = await apiProvider.client.post(
        "/api/books/create",
        data: {"title": title, "author": author, "isbn": isbn},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return BookModel.fromJson(data);
      }
      return null;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
      return null;
    }
  }

  @override
  Future<void> deleteBook(String bookId) async {
    try {
      await apiProvider.client.delete("/api/books/$bookId");
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
    }
  }

  @override
  Future<void> borrowBook(String memberId, String bookId) async {
    try {
      await apiProvider.client.post(
        "/api/books/$bookId/borrow?memberId=$memberId",
      );
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
    }
  }

  @override
  Future<void> returnBook(String memberId, String bookId) async {
    try {
      await apiProvider.client.post(
        "/api/books/$bookId/return?memberId=$memberId",
      );
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? e.toString());
    }
  }
}
