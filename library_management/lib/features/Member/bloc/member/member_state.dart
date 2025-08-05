part of 'member_bloc.dart';

class MemberState {}

class MemberInitial extends MemberState {}

class LoadingMembers extends MemberState {}

class LoadedMembers extends MemberState {
  final List<MemberModel> members;
  LoadedMembers({required this.members});
}

class LoadedMember extends MemberState {
  final MemberModel member;
  LoadedMember({required this.member});
}

class FailedMembers extends MemberState {}
