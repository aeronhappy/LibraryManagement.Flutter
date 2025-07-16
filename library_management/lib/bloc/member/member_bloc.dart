import 'package:bloc/bloc.dart';
import 'package:library_management/datasource/member_remote_datesource.dart';
import 'package:library_management/model/member_model.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final IMemberRemoteDatasource memberRemoteDatasource;
  MemberBloc({required this.memberRemoteDatasource}) : super(MemberInitial()) {
    on<GetAllMembers>((event, emit) async {
      List<MemberModel> members = await memberRemoteDatasource.getMembers(
        event.searchText,
      );
      emit(LoadedMembers(members: members));
    });
  }
}
