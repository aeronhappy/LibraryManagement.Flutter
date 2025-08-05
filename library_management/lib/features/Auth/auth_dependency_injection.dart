import 'package:get_it/get_it.dart';
import 'package:library_management/features/Auth/bloc/auth/auth_bloc.dart';
import 'package:library_management/features/Auth/bloc/role/role_bloc.dart';
import 'package:library_management/features/Auth/datasource/auth_remote_datasource.dart';

Future<void> registerAuth(GetIt sl) async {
  sl.registerFactory(
    () => AuthBloc(authRemoteDatasource: sl(), sharedPreferences: sl()),
  );
  sl.registerFactory(() => RoleBloc(authRemoteDatasource: sl()));

  //RemoteDataSource
  sl.registerLazySingleton<IAuthRemoteDatasource>(
    () => AuthRemoteDatasource(apiProvider: sl()),
  );
}
