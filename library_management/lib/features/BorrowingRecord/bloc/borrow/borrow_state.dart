part of 'borrow_bloc.dart';

class BorrowState {}

class BorrowRecordInitial extends BorrowState {}

class LoadingBorrowRecord extends BorrowState {}

class LoadedBorrowRecord extends BorrowState {
  final List<BorrowingRecordModel> borrowingRecords;
  LoadedBorrowRecord({required this.borrowingRecords});
}

class FailedBorrowRecord extends BorrowState {}
