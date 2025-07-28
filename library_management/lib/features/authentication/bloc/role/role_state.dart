part of 'role_bloc.dart';

class RoleState {}

class RoleInitial extends RoleState {}

class LoadingRole extends RoleState {}

class LoadedRole extends RoleState {
  final List<RoleModel> roles;
  LoadedRole({required this.roles});
}

class FailedRole extends RoleState {}
