// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:library_management/themes/theme_cubit/theme_cubit.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 40,
      padding: 1.5,
      height: 21,
      toggleSize: 20.0,
      activeToggleColor: Colors.white,
      inactiveToggleColor: Colors.white,
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Theme.of(context).disabledColor,
      value: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark,
      onToggle: (value) async {
        context.read<ThemeCubit>().changeThemeMode(
          value ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
