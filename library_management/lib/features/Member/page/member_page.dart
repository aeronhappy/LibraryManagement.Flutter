import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/features/Book/bloc/book_controller/book_controller_bloc.dart';
import 'package:library_management/features/Member/bloc/member/member_bloc.dart';
import 'package:library_management/features/Member/bloc/member_controller/member_controller_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/features/Member/model/create_member_model.dart';
import 'package:library_management/widgets/add_member_dialog.dart';
import 'package:library_management/widgets/borrow_book_dialog.dart';
import 'package:library_management/widgets/return_book_dialog.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  refreshData() {
    context.read<MemberBloc>().add(
      GetAllMembers(searchText: searchTextController.text),
    );
  }

  Future<void> searchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    refreshData();
  }

  void addMembers(CreateMemberModel createMemberModel) {
    context.read<MemberControllerBloc>().add(
      AddMember(createMemberModel: createMemberModel),
    );
  }

  void borrowBooks(String memberId, String bookId) {
    context.read<BookControllerBloc>().add(
      BorrowBook(bookId: bookId, memberId: memberId),
    );
  }

  void returnBooks(String memberId, String bookId) {
    context.read<BookControllerBloc>().add(
      ReturnBook(bookId: bookId, memberId: memberId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MemberControllerBloc, MemberControllerState>(
          listener: (context, state) {
            if (state is MemberCreated) {
              refreshData();
            }
            if (state is MemberDeleted) {
              refreshData();
            }
          },
        ),
        BlocListener<BookControllerBloc, BookControllerState>(
          listener: (context, state) {
            if (state is BorrowedBook) {
              refreshData();
            }
            if (state is ReturnedBook) {
              refreshData();
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
                        "Member",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacer(),
                      Material(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(45),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(45),
                          onTap: () async {
                            var createMemberModel = await addMemberDialog(
                              context,
                            );

                            if (!mounted) return;

                            if (createMemberModel != null) {
                              addMembers(createMemberModel);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            child: Center(
                              child: Text("Add Member", style: bodyMediumDark),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: navBarIconColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: searchTextController,
                            style: bodyMediumLight,
                            textAlignVertical: TextAlignVertical.top,
                            onChanged: (value) => searchData(),
                            decoration: InputDecoration(
                              hintText: 'Search member name or email . . .',
                              hintStyle: bodyMediumLight.copyWith(
                                decoration: TextDecoration.none,
                                color: navBarIconColor,
                                height: 2,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: navBarIconColor,
                              ),
                              suffixIcon: searchTextController.text.isEmpty
                                  ? null
                                  : IconButton(
                                      icon: const Icon(Icons.close, size: 20),
                                      onPressed: () {
                                        setState(() {
                                          searchTextController.clear();
                                          refreshData();
                                        });
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: BlocBuilder<MemberBloc, MemberState>(
                      builder: (context, state) {
                        if (state is LoadedMembers) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              double maxWidth = constraints.maxWidth;
                              double desiredItemWidth = 300;
                              int crossAxisCount = (maxWidth / desiredItemWidth)
                                  .floor()
                                  .clamp(1, 5);
                              double spacing = 15.0;

                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      mainAxisSpacing: spacing,
                                      crossAxisSpacing: spacing,
                                      mainAxisExtent: 165,
                                    ),
                                itemCount: state.members.length,
                                itemBuilder: (context, index) {
                                  var member = state.members[index];
                                  var baseUrl = "http://localhost:5184";
                                  var imageUrl =
                                      "$baseUrl${member.profilePictureUrl}";
                                  return Stack(
                                    children: [
                                      Material(
                                        elevation: 0.5,
                                        borderRadius: BorderRadius.circular(12),
                                        color: primaryColor.withAlpha(120),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            50,
                                                          ),
                                                    ),
                                                    child:
                                                        member.profilePictureUrl !=
                                                            null
                                                        ? Image.network(
                                                            imageUrl,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            "assets/icon/profile_image.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        member.name,
                                                        style: titleMediumLight
                                                            .copyWith(
                                                              height: 1,
                                                            ),
                                                      ),

                                                      Text(
                                                        member.email,
                                                        style: bodySmallLight,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Borrow books: ${member.borrowedBooksCount == 0 ? "None" : member.borrowedBooksCount}",
                                                style: bodySmallLight,
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  member.borrowedBooksCount ==
                                                          member.maxBooksAllowed
                                                      ? Expanded(
                                                          child: Opacity(
                                                            opacity: .3,
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    50,
                                                                  ),

                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      50,
                                                                    ),
                                                                onTap: null,
                                                                child: SizedBox(
                                                                  height: 40,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Reach Max Limit",
                                                                      style:
                                                                          labelLargeLight,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  50,
                                                                ),

                                                            child: InkWell(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    50,
                                                                  ),
                                                              onTap: () async {
                                                                var listOfString =
                                                                    await borrowBookDialog(
                                                                      context,
                                                                      member,
                                                                    );

                                                                if (listOfString !=
                                                                    null) {
                                                                  borrowBooks(
                                                                    listOfString[0],
                                                                    listOfString[1],
                                                                  );
                                                                }
                                                              },
                                                              child: SizedBox(
                                                                height: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    "Borrow Book",
                                                                    style:
                                                                        bodyMediumLight,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Opacity(
                                                      opacity:
                                                          member.borrowedBooksCount ==
                                                              0
                                                          ? .3
                                                          : 1,
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                50,
                                                              ),
                                                          onTap:
                                                              member.borrowedBooksCount ==
                                                                  0
                                                              ? null
                                                              : () async {
                                                                  var listOfString =
                                                                      await returnBookDialog(
                                                                        context,
                                                                        member,
                                                                      );

                                                                  if (listOfString !=
                                                                      null) {
                                                                    returnBooks(
                                                                      listOfString[0],
                                                                      listOfString[1],
                                                                    );
                                                                  }
                                                                },
                                                          child: SizedBox(
                                                            height: 40,
                                                            child: Center(
                                                              child: Text(
                                                                "Return Book",
                                                                style:
                                                                    bodyMediumLight,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            onTap: () {
                                              context
                                                  .read<MemberControllerBloc>()
                                                  .add(
                                                    DeleteMember(
                                                      memberId: member.id,
                                                    ),
                                                  );
                                            },
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        }
                        return Center(child: Text("wala nga ni"));
                      },
                    ),
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
