part of 'member_controller_bloc.dart';

class MemberControllerEvent {}

class AddMember extends MemberControllerEvent {
  final CreateMemberModel createMemberModel;
  AddMember({required this.createMemberModel});
}

class DeleteMember extends MemberControllerEvent {
  final String memberId;
  DeleteMember({required this.memberId});
}

class UpdateProfilePicture extends MemberControllerEvent {
  final File imageFile;
  UpdateProfilePicture({required this.imageFile});
}
