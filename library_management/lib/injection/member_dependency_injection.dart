import 'package:get_it/get_it.dart';
import 'package:library_management/bloc/member/member_bloc.dart';
import 'package:library_management/bloc/member_controller/member_controller_bloc.dart';
import 'package:library_management/datasource/member_remote_datesource.dart';

Future<void> registerMember(GetIt sl) async {
  sl.registerFactory(() => MemberBloc(memberRemoteDatasource: sl()));
  sl.registerFactory(() => MemberControllerBloc(memberRemoteDatasource: sl()));

  //RemoteDataSource
  sl.registerLazySingleton<IMemberRemoteDatasource>(
    () => MemberRemoteDatasource(apiProvider: sl()),
  );
}
