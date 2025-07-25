import 'package:get_it/get_it.dart';
import 'package:library_management/bloc/book/book_bloc.dart';
import 'package:library_management/bloc/book_controller/book_controller_bloc.dart';
import 'package:library_management/datasource/book_remote_datesource.dart';

Future<void> registerBook(GetIt sl) async {
  sl.registerFactory(() => BookBloc(bookRemoteDatasource: sl()));
  sl.registerFactory(() => BookControllerBloc(bookRemoteDatasource: sl()));

  //RemoteDataSource
  sl.registerLazySingleton<IBookRemoteDatasource>(
    () => BookRemoteDatasource(apiProvider: sl()),
  );
}
