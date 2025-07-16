part of 'book_bloc.dart';

class BookEvent {}

class GetAllBooks extends BookEvent {
  final String searchText;
  final BookFilterTypes bookFilterTypes;
  GetAllBooks({required this.searchText, required this.bookFilterTypes});
}
