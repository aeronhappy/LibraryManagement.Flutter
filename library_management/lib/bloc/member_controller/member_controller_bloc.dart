import 'package:bloc/bloc.dart';
import 'package:library_management/datasource/member_remote_datesource.dart';
import 'package:library_management/model/create_member_model.dart';

part 'member_controller_event.dart';
part 'member_controller_state.dart';

class MemberControllerBloc
    extends Bloc<MemberControllerEvent, MemberControllerState> {
  final IMemberRemoteDatasource memberRemoteDatasource;
  MemberControllerBloc({required this.memberRemoteDatasource})
    : super(MemberControllerInitial()) {
    on<AddMember>((event, emit) async {
      await memberRemoteDatasource.addMember(event.createMemberModel);
      emit(MemberCreated());
    });

    on<DeleteMember>((event, emit) async {
      await memberRemoteDatasource.deleteMember(event.memberId);
      emit(MemberDeleted());
    });
  }
}
