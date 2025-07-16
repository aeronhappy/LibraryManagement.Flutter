part of 'book_controller_bloc.dart';

class BookControllerEvent {}

class AddBook extends BookControllerEvent {
  final String title;
  final String author;
  final String isbn;
  AddBook({required this.title, required this.author, required this.isbn});
}

class DeleteBook extends BookControllerEvent {
  final String bookId;
  DeleteBook({required this.bookId});
}

class BorrowBook extends BookControllerEvent {
  final String bookId;
  final String memberId;
  BorrowBook({required this.bookId, required this.memberId});
}

class ReturnBook extends BookControllerEvent {
  final String bookId;
  final String memberId;
  ReturnBook({required this.bookId, required this.memberId});
}
