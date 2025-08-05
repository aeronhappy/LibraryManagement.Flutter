import 'package:library_management/features/Book/model/book_model.dart';
import 'package:library_management/features/Member/model/member_model.dart';

class BorrowingRecordModel {
  final String id;
  final BookModel? book;
  final MemberModel? borrower;
  final DateTime dateBorrowed;
  final DateTime dateOverdue;
  final DateTime? dateReturned;

  BorrowingRecordModel({
    required this.id,
    this.book,
    this.borrower,
    required this.dateBorrowed,
    required this.dateOverdue,
    this.dateReturned,
  });

  factory BorrowingRecordModel.fromJson(Map<String, dynamic> json) {
    return BorrowingRecordModel(
      id: json['id'],
      book: json['book'] != null ? BookModel.fromJson(json['book']) : null,
      borrower: json['borrower'] != null
          ? MemberModel.fromJson(json['borrower'])
          : null,
      dateBorrowed: DateTime.parse(json['dateBorrowed']),
      dateOverdue: DateTime.parse(json['dateOverdue']),
      dateReturned: json['dateReturned'] != null
          ? DateTime.parse(json['dateReturned'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book': book!.toJson(),
      'borrower': borrower!.toJson(),
      'dateBorrowed': dateBorrowed.toIso8601String(),
      'dateOverdue': dateOverdue.toIso8601String(),
      'dateReturned': dateReturned?.toIso8601String(),
    };
  }
}
