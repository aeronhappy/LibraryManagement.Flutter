part of 'member_bloc.dart';

class MemberEvent {}

class GetAllMembers extends MemberEvent {
  final String searchText;
  GetAllMembers({required this.searchText});
}

class GetMyProfile extends MemberEvent {}
