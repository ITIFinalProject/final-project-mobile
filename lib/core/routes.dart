import 'package:eventify_app/features/Home.dart';
import 'package:eventify_app/features/auth/login.dart';
import 'package:eventify_app/features/auth/register.dart';
import 'package:eventify_app/features/onboarding/onboarding_screen.dart';
import 'package:eventify_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = "/";
  static const String onBoarding = "/on_boarding";
  static const String login = "/login";
  static const String register = "/register";
static const String homeScreen= "/home";
  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    onBoarding: (context) => OnboardingScreen(),
    login: (context) => LoginView(),
    register: (context) => RegisterView(),
    homeScreen:(context) => HomeView()
  };
}
