import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/themes/theme_cubit/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeMode.light, Color(0xffCF8F6E))) {
    initialize();
  }

  void changeThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', themeMode == ThemeMode.dark);
    emit(ThemeState(themeMode, state.primaryColor));
  }

  void changePrimaryColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', color.toARGB32());
    emit(ThemeState(state.themeMode, color));
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final primaryColor = Color(
      prefs.getInt('primaryColor') ?? Color(0xffCF8F6E).toARGB32(),
    );
    emit(
      ThemeState(isDarkMode ? ThemeMode.dark : ThemeMode.light, primaryColor),
    );
  }
}
