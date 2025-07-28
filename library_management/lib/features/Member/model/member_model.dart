import 'package:library_management/features/Book/model/book_model.dart';

class MemberModel {
  final String id;
  final String name;
  final String email;
  final int maxBooksAllowed;
  final int borrowedBooksCount;
  final List<BookModel> borrowedBooks;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.maxBooksAllowed,
    required this.borrowedBooksCount,
    this.borrowedBooks = const [],
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      maxBooksAllowed: json['maxBooksAllowed'] as int,
      borrowedBooksCount: json['borrowedBooksCount'] as int,
      borrowedBooks:
          (json['borrowedBooks'] as List<dynamic>?)
              ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
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
      'borrowedBooks': borrowedBooks.map((e) => e.toJson()).toList(),
    };
  }
}
