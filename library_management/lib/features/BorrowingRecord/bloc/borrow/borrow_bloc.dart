import 'package:bloc/bloc.dart';
import 'package:library_management/features/BorrowingRecord/datasource/borrowing_remote_datesource.dart';
import 'package:library_management/features/BorrowingRecord/model/borrowing_record_model.dart';

part 'borrow_event.dart';
part 'borrow_state.dart';

class BorrowBloc extends Bloc<BorrowEvent, BorrowState> {
  IBorrowingRemoteDatasource borrowingRemoteDatasource;
  BorrowBloc({required this.borrowingRemoteDatasource})
    : super(BorrowRecordInitial()) {
    on<GetAllBorrowingRecords>((event, emit) async {
      var borrowingRecords = await borrowingRemoteDatasource
          .getAllBorrowingRecords(event.searchText, event.dateTime);

      emit(LoadedBorrowRecord(borrowingRecord: borrowingRecords));
    });
  }
}
