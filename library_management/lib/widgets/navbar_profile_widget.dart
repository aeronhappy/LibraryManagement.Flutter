import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/features/Member/bloc/member/member_bloc.dart';

class NavbarProfileWidget extends StatefulWidget {
  final bool isExtend;
  const NavbarProfileWidget({super.key, required this.isExtend});

  @override
  State<NavbarProfileWidget> createState() => _NavbarProfileWidgetState();
}

class _NavbarProfileWidgetState extends State<NavbarProfileWidget> {
  @override
  void initState() {
    super.initState();
    context.read<MemberBloc>().add(GetMyProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      builder: (context, state) {
        if (state is LoadedMember) {
          var baseUrl = "http://localhost:5184";
          var imageUrl = "$baseUrl${state.member.profilePictureUrl}";
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: state.member.profilePictureUrl != null
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : Image.asset(
                        "assets/icon/profile_image.png",
                        fit: BoxFit.cover,
                      ),
              ),
              if (widget.isExtend) ...[
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.member.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      state.member.email,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ],
            ],
          );
        }
        return Container();
      },
    );
  }
}
