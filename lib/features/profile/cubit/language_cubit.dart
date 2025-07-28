import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void setEnglish() => emit(const Locale('en'));
  void setArabic() => emit(const Locale('ar'));
  void toggleLanguage() {
    emit(state.languageCode == 'en' ? const Locale('ar') : const Locale('en'));
  }
}
