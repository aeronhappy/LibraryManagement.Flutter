part of 'borrow_bloc.dart';

class BorrowEvent {}

class GetAllBorrowingRecords extends BorrowEvent {
  final String searchText;
  final DateTime? dateTime;
  final BorrowRecordsFilterTypes borrowRecordsFilterTypes;
  GetAllBorrowingRecords({
    required this.searchText,
    required this.dateTime,
    required this.borrowRecordsFilterTypes,
  });
}
