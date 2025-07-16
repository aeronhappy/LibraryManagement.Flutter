part of 'book_controller_bloc.dart';

class BookControllerState {}

final class BookControllerInitial extends BookControllerState {}

final class BookCreated extends BookControllerState {}

final class BookDeleted extends BookControllerState {}

final class BorrowedBook extends BookControllerState {}

final class ReturnedBook extends BookControllerState {}
