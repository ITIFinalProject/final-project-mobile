// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeCubit extends Cubit<ThemeMode> {
//   ThemeCubit() : super(ThemeMode.light);

//   void toggleTheme() {
//     emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
//   }

//   void setLight() => emit(ThemeMode.light);
//   void setDark() => emit(ThemeMode.dark);
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme(); 
  }


  void toggleTheme() {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    _saveTheme(newTheme);
  }


  void setLight() {
    emit(ThemeMode.light);
    _saveTheme(ThemeMode.light);
  }


  void setDark() {
    emit(ThemeMode.dark);
    _saveTheme(ThemeMode.dark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _saveTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', theme == ThemeMode.dark);
  }
}
