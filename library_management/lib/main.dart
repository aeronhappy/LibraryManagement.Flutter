import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/injection/injection_container.dart' as di;
import 'package:library_management/router/app_router.dart';
import 'package:library_management/themes/my_themes.dart';
import 'package:library_management/themes/theme_cubit/theme_cubit.dart';
import 'package:library_management/themes/theme_cubit/theme_state.dart';

void main() async {
  await di.init();
  runApp(BlocProvider(create: (context) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Library Management',
          debugShowCheckedModeBanner: false,
          color: Theme.of(context).primaryColor,
          theme: MyThemes.lightTheme(primaryColor),
          darkTheme: MyThemes.darkTheme(secondaryColor),
          themeMode: state.themeMode,
          onGenerateRoute: AppRouter().onGenerateRoute,
        );
      },
    );
  }
}
