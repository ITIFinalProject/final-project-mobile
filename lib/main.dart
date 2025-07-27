import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'features/events/event_cubit/event_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://fibsnglrcxgjvbhytzvp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpYnNuZ2xyY3hnanZiaHl0enZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM1NDY0NzAsImV4cCI6MjA2OTEyMjQ3MH0.Z7NTozQca44lJyCtkNmLY8XttKam78xWTqBYJaTrvJ4',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),),
          BlocProvider(
            create: (context) => CreateEventCubit(),
          ),
          BlocProvider(create: (context) => EventCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.splash,
          theme: ThemeManager.lightTheme,
          darkTheme: ThemeManager.darkTheme,
          locale: Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        )
    );
  }
}
