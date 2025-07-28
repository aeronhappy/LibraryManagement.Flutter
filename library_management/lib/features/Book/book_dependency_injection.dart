import 'package:get_it/get_it.dart';
import 'package:library_management/features/Book/bloc/book_controller/book_controller_bloc.dart';
import 'package:library_management/features/Book/datasource/book_remote_datesource.dart';
import 'package:library_management/features/Book/bloc/book/book_bloc.dart';

Future<void> registerBook(GetIt sl) async {
  sl.registerFactory(() => BookBloc(bookRemoteDatasource: sl()));
  sl.registerFactory(() => BookControllerBloc(bookRemoteDatasource: sl()));

  //RemoteDataSource
  sl.registerLazySingleton<IBookRemoteDatasource>(
    () => BookRemoteDatasource(apiProvider: sl()),
  );
}
