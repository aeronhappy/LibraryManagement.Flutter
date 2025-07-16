part of 'book_bloc.dart';

class BookState {}

class BookInitial extends BookState {}

class LoadingBook extends BookState {}

class LoadedBook extends BookState {
  final List<BookModel> books;
  LoadedBook({required this.books});
}

class FailedBook extends BookState {}
