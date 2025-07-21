import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class ThemeCubit extends Cubit<AppThemeMode> {
  static const _themeKey = 'app_theme_mode';

  ThemeCubit() : super(AppThemeMode.system) {
    loadTheme(); // تحميل الثيم المخزن عند الإنشاء
  }

  Future<void> setTheme(AppThemeMode mode) async {
    emit(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index); // index 0, 1, 2
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeKey);

    if (index != null && index >= 0 && index < AppThemeMode.values.length) {
      emit(AppThemeMode.values[index]);
    }
  }

  ThemeMode get currentThemeMode {
    switch (state) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
