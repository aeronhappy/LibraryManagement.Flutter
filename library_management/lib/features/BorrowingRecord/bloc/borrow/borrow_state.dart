part of 'borrow_bloc.dart';

class BorrowState {}

class BorrowRecordInitial extends BorrowState {}

class LoadingBorrowRecord extends BorrowState {}

class LoadedBorrowRecord extends BorrowState {
  final List<BorrowingRecordModel> borrowingRecord;
  LoadedBorrowRecord({required this.borrowingRecord});
}

class FailedBorrowRecord extends BorrowState {}
