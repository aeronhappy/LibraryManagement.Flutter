import 'package:library_management/features/BorrowingRecord/model/borrowing_record_model.dart';

class MemberModel {
  final String id;
  final String name;
  final String email;
  final int maxBooksAllowed;
  final int borrowedBooksCount;
  final List<BorrowingRecordModel> borrowingHistory;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.maxBooksAllowed,
    required this.borrowedBooksCount,
    this.borrowingHistory = const [],
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      maxBooksAllowed: json['maxBooksAllowed'] as int,
      borrowedBooksCount: json['borrowedBooksCount'] as int,
      borrowingHistory:
          (json['borrowingHistory'] as List<dynamic>?)
              ?.map(
                (e) => BorrowingRecordModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'maxBooksAllowed': maxBooksAllowed,
      'borrowedBooksCount': borrowedBooksCount,
      'borrowingHistory': borrowingHistory.map((e) => e.toJson()).toList(),
    };
  }
}
