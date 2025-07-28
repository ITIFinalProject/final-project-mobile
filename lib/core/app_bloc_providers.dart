import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/core/theme_cubit.dart';
import 'package:eventify_app/core/language_cubit.dart';

final appBlocProviders = [
  BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
  BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
];
