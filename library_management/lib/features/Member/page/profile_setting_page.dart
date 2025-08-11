import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management/features/Member/bloc/member/member_bloc.dart';
import 'package:library_management/features/Member/bloc/member_controller/member_controller_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<MemberBloc>().add(GetMyProfile());
  }

  Future<void> updateProfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      File imageFile = File(result.files.single.path!);

      // ignore: use_build_context_synchronously
      context.read<MemberControllerBloc>().add(
        UpdateProfilePicture(imageFile: imageFile),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MemberControllerBloc, MemberControllerState>(
          listener: (context, state) {
            if (state is ProfilePictureChanged) {
              context.read<MemberBloc>().add(GetMyProfile());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Profile",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<MemberBloc, MemberState>(
                    builder: (context, state) {
                      if (state is LoadedMember) {
                        var baseUrl = "http://localhost:5184";
                        var imageUrl =
                            "$baseUrl${state.member.profilePictureUrl}";
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: state.member.profilePictureUrl != null
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/icon/profile_image.png",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: updateProfile,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor.withAlpha(200),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 10),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.member.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                Text(
                                  state.member.email,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
