import 'package:library_management/features/BorrowingRecord/model/borrowing_record_model.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final bool isBorrowed;
  final List<BorrowingRecordModel>? borrowingHistory;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.isBorrowed,
    required this.borrowingHistory,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String,
      isBorrowed: json['isBorrowed'] as bool,
      borrowingHistory: (json['borrowingHistory'] as List<dynamic>?)
          ?.map((e) => BorrowingRecordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'isbn': isbn,
    'isBorrowed': isBorrowed,
    'borrowingHistory': borrowingHistory?.map((e) => e.toJson()).toList(),
  };
}
