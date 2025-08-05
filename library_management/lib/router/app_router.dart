import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/features/Auth/bloc/auth/auth_bloc.dart';
import 'package:library_management/features/Auth/bloc/role/role_bloc.dart';
import 'package:library_management/features/Auth/page/authentication_page.dart';
import 'package:library_management/features/Auth/page/register_page.dart';
import 'package:library_management/features/Member/bloc/member/member_bloc.dart';
import 'package:library_management/features/main_navbar_page.dart';
import 'package:library_management/injection/injection_container.dart';
import 'package:library_management/router/router_type.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      ///Common
      case PageRouter.authenticationPage:
        return MaterialPageRoute(
          builder: ((context) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
            child: AuthenticationPage(),
          )),
        );

      case PageRouter.registerPage:
        return MaterialPageRoute(
          builder: ((context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<AuthBloc>()),
              BlocProvider(create: (context) => sl<RoleBloc>()),
            ],
            child: RegisterPage(),
          )),
        );

      case PageRouter.mainNavbarPage:
        return MaterialPageRoute(
          builder: ((context) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => sl<MemberBloc>())],
            child: MainNavbarPage(),
          )),
        );

      //Default
      default:
        return MaterialPageRoute(
          builder: ((context) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
            child: AuthenticationPage(),
          )),
        );
    }
  }
}
