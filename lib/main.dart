import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/logic/invite_state_cubit/invite_cubit.dart';
import 'package:eventify_app/features/add_memory/cubit/memory_cubit.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:eventify_app/features/home/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'features/events/event_cubit/event_cubit.dart';
import 'features/profile/cubit/language_cubit.dart';
import 'features/profile/cubit/theme_cubit.dart';
import 'generated/l10n.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Future<void> setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  await messaging.requestPermission();

  String? token = await messaging.getToken();
  print("🔐 FCM Token: $token");

  final user = FirebaseAuth.instance.currentUser;
  if (user != null && token != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'fcmToken': token,
    });
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("📩 Received message: ${message.notification?.title}");

  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("🚪 Notification opened");
  });
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://fibsnglrcxgjvbhytzvp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpYnNuZ2xyY3hnanZiaHl0enZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM1NDY0NzAsImV4cCI6MjA2OTEyMjQ3MH0.Z7NTozQca44lJyCtkNmLY8XttKam78xWTqBYJaTrvJ4',
  );

  await dotenv.load(fileName: ".env");
  await setupFCM();
  runApp(const MyApp());
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
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) =>
        EventCubit()
          ..fetchEvents()),
          // BlocProvider(create: (context) => InviteCubit()),
        BlocProvider(create: (context)=>MemoryCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                navigatorObservers: [routeObserver],
                debugShowCheckedModeBanner: false,
                routes: AppRoutes.routes,
                initialRoute: AppRoutes.splash,
                theme: ThemeManager.lightTheme,
                darkTheme: ThemeManager.darkTheme,
                themeMode: themeMode,
                locale: locale,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              );
            },
          );
        },
      ),
    );
  }


}

