import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/features/Book/bloc/book/book_bloc.dart';
import 'package:library_management/features/Book/bloc/book_controller/book_controller_bloc.dart';
import 'package:library_management/features/Member/bloc/member/member_bloc.dart';
import 'package:library_management/features/Member/bloc/member_controller/member_controller_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/features/Book/page/book_page.dart';
import 'package:library_management/features/authentication/bloc/auth/auth_bloc.dart';
import 'package:library_management/features/authentication/bloc/role/role_bloc.dart';
import 'package:library_management/features/authentication/page/authentication_page.dart';
import 'package:library_management/injection/injection_container.dart';
import 'package:library_management/features/Member/page/member_page.dart';

class MainNavbarPage extends StatefulWidget {
  const MainNavbarPage({super.key});

  @override
  State<MainNavbarPage> createState() => _MainNavbarPageState();
}

class _MainNavbarPageState extends State<MainNavbarPage> {
  late PageController pageController;
  bool isExtended = false;
  int selectedIndex = 0;

  IconData navbarIcon(int index) {
    if (index == 0) return Icons.menu_book_rounded;
    if (index == 1) return Icons.login;
    return Icons.group;
  }

  String navbarText(int index) {
    if (index == 0) return "Books";
    if (index == 1) return "Login";
    return "Members";
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                isExtended = !isExtended;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                  if (isExtended) SizedBox(width: 10),
                                  if (isExtended)
                                    Text(
                                      "Library Management",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: navBarIconColor, thickness: 1),
                          ...List.generate(3, (index) {
                            return Stack(
                              children: [
                                NavBarButtonWidget(
                                  isSelected: selectedIndex == index,
                                  isExtended: isExtended,
                                  imageAsset: navbarIcon(index),
                                  navbarText: navbarText(index),
                                  function: () {
                                    setState(() {
                                      selectedIndex = index;
                                      pageController.animateToPage(
                                        index,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear,
                                      );
                                    });
                                  },
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            VerticalDivider(width: 1, color: navBarIconColor),
            Expanded(
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<BookBloc>()),
                      BlocProvider(
                        create: (context) => sl<BookControllerBloc>(),
                      ),
                    ],
                    child: BookPage(),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<AuthBloc>()),
                      BlocProvider(create: (context) => sl<RoleBloc>()),
                    ],
                    child: AuthenticationPage(),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<MemberBloc>()),
                      BlocProvider(
                        create: (context) => sl<MemberControllerBloc>(),
                      ),
                      BlocProvider(
                        create: (context) => sl<BookControllerBloc>(),
                      ),
                    ],
                    child: MemberPage(),
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

// ignore: must_be_immutable
class NavBarButtonWidget extends StatelessWidget {
  final bool isSelected;
  final bool isExtended;
  final IconData imageAsset;
  final String navbarText;
  final Function() function;
  Function(bool value)? onHover;

  NavBarButtonWidget({
    super.key,
    required this.isSelected,
    required this.isExtended,
    required this.imageAsset,
    required this.navbarText,
    required this.function,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              imageAsset,
              size: 26,
              color: isSelected ? primaryColor : navBarIconColor,
            ),
            if (isExtended) ...[
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  navbarText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: isSelected ? primaryColor : navBarIconColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
