part of 'borrow_bloc.dart';

class BorrowEvent {}

class GetAllBorrowingRecords extends BorrowEvent {
  final String searchText;
  final DateTime? dateTime;
  GetAllBorrowingRecords({required this.searchText, required this.dateTime});
}
