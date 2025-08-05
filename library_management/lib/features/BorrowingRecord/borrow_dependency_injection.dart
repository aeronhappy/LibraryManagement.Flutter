import 'package:get_it/get_it.dart';
import 'package:library_management/features/BorrowingRecord/bloc/borrow/borrow_bloc.dart';
import 'package:library_management/features/BorrowingRecord/datasource/borrowing_remote_datesource.dart';

Future<void> registerBorrowRecord(GetIt sl) async {
  sl.registerFactory(() => BorrowBloc(borrowingRemoteDatasource: sl()));

  //RemoteDataSource
  sl.registerLazySingleton<IBorrowingRemoteDatasource>(
    () => BorrowingRemoteDatasource(apiProvider: sl()),
  );
}
