import 'package:bloc/bloc.dart';
import 'package:library_management/features/Auth/datasource/auth_remote_datasource.dart';
import 'package:library_management/features/Auth/model/role_model.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final IAuthRemoteDatasource authRemoteDatasource;
  RoleBloc({required this.authRemoteDatasource}) : super(RoleInitial()) {
    on<GetAllRoles>((event, emit) async {
      List<RoleModel> roles = await authRemoteDatasource.getRoles();
      emit(LoadedRole(roles: roles));
    });
  }
}
