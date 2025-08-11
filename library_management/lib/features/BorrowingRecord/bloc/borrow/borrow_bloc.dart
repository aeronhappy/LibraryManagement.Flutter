import 'package:bloc/bloc.dart';
import 'package:library_management/features/BorrowingRecord/datasource/borrowing_remote_datesource.dart';
import 'package:library_management/features/BorrowingRecord/model/borrowing_record_model.dart';
import 'package:library_management/types/borrow_records_filter_types.dart';

part 'borrow_event.dart';
part 'borrow_state.dart';

class BorrowBloc extends Bloc<BorrowEvent, BorrowState> {
  IBorrowingRemoteDatasource borrowingRemoteDatasource;
  BorrowBloc({required this.borrowingRemoteDatasource})
    : super(BorrowRecordInitial()) {
    on<GetAllBorrowingRecords>((event, emit) async {
      List<BorrowingRecordModel> borrowRecords = [];

      if (event.borrowRecordsFilterTypes == BorrowRecordsFilterTypes.all) {
        borrowRecords = await borrowingRemoteDatasource.getAllRecords(
          event.searchText,
          event.dateTime,
        );
      }
      if (event.borrowRecordsFilterTypes ==
          BorrowRecordsFilterTypes.unreturned) {
        borrowRecords = await borrowingRemoteDatasource.getUnreturnedRecords(
          event.searchText,
          event.dateTime,
        );
      }
      if (event.borrowRecordsFilterTypes == BorrowRecordsFilterTypes.returned) {
        borrowRecords = await borrowingRemoteDatasource.getReturnedRecords(
          event.searchText,
          event.dateTime,
        );
      }

      emit(LoadedBorrowRecord(borrowingRecords: borrowRecords));
    });
  }
}
