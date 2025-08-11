import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/features/Book/bloc/book/book_bloc.dart';
import 'package:library_management/features/Book/bloc/book_controller/book_controller_bloc.dart';
import 'package:library_management/features/BorrowingRecord/bloc/borrow/borrow_bloc.dart';
import 'package:library_management/features/BorrowingRecord/page/borrow_record_page.dart';
import 'package:library_management/features/Member/bloc/member/member_bloc.dart';
import 'package:library_management/features/Member/bloc/member_controller/member_controller_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/features/Book/page/book_page.dart';
import 'package:library_management/features/Member/page/profile_setting_page.dart';
import 'package:library_management/injection/injection_container.dart';
import 'package:library_management/features/Member/page/member_page.dart';
import 'package:library_management/router/router_type.dart';
import 'package:library_management/themes/change_theme_button_widget.dart';
import 'package:library_management/widgets/navbar_profile_widget.dart';

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
    if (index == 1) return Icons.group;
    if (index == 2) return Icons.receipt_rounded;
    if (index == 3) return Icons.settings_rounded;
    return Icons.logout_rounded;
  }

  String navbarText(int index) {
    if (index == 0) return "Books";
    if (index == 1) return "Members";
    if (index == 2) return "Borrowing Records";
    if (index == 3) return "Settings";
    return "Logout";
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    context.read<MemberBloc>().add(GetMyProfile());
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
                              child: NavbarProfileWidget(isExtend: isExtended),
                            ),
                          ),
                          Divider(color: navBarIconColor, thickness: 1),
                          ...List.generate(4, (index) {
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
                      Divider(color: navBarIconColor, thickness: 1, height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ChangeThemeButtonWidget(),
                      ),
                      NavBarButtonWidget(
                        isSelected: false,
                        isExtended: isExtended,
                        imageAsset: navbarIcon(4),
                        navbarText: navbarText(4),
                        function: () {
                          Navigator.pushReplacementNamed(
                            context,
                            PageRouter.authenticationPage,
                          );
                        },
                      ),
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

                  MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<BorrowBloc>()),
                    ],
                    child: BorrowRecordPage(),
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
                    child: SettingPage(),
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
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : navBarIconColor,
            ),
            if (isExtended) ...[
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  navbarText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : navBarIconColor,
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
