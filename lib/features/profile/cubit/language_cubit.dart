// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class LanguageCubit extends Cubit<Locale> {
//   LanguageCubit() : super(const Locale('en'));
//
//   void setEnglish() => emit(const Locale('en'));
//   void setArabic() => emit(const Locale('ar'));
//   void toggleLanguage() {
//     emit(state.languageCode == 'en' ? const Locale('ar') : const Locale('en'));
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')) {
    _loadLanguage(); // تحميل اللغة المحفوظة عند بدء التطبيق
  }

  // تحميل اللغة من SharedPreferences
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('languageCode') ?? 'en';
    emit(Locale(langCode));
  }

  // حفظ اللغة في SharedPreferences
  Future<void> _saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', langCode);
  }

  void setEnglish() {
    emit(const Locale('en'));
    _saveLanguage('en');
  }

  void setArabic() {
    emit(const Locale('ar'));
    _saveLanguage('ar');
  }

  void toggleLanguage() {
    final newLang = state.languageCode == 'en' ? 'ar' : 'en';
    emit(Locale(newLang));
    _saveLanguage(newLang);
  }
}
