import 'package:eventify_app/features/auth/login.dart';
import 'package:eventify_app/features/auth/register.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = "/login";
  static const String register = "/register";

  static final routes = <String, WidgetBuilder>{
    login: (context) => LoginView(),
    register: (context) => RegisterView(),
  };
}
