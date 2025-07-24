import 'package:eventify_app/features/add_event/add_event_view.dart';
import 'package:eventify_app/features/add_event/create_contact.dart';
import 'package:eventify_app/features/add_event/event_details_view.dart';
import 'package:eventify_app/features/add_event/evevnt_preview.dart';
import 'package:eventify_app/features/auth/login.dart';
import 'package:eventify_app/features/auth/register.dart';
import 'package:eventify_app/features/events/event_details.dart';
import 'package:eventify_app/features/layout/layout.dart';
import 'package:eventify_app/features/onboarding/onboarding_screen.dart';
import 'package:eventify_app/features/profile/edit_profile.dart';
import 'package:eventify_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = "/";
  static const String onBoarding = "/on_boarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String layout = "/layout";
  static const String addEvent = '/add_event';
  static const String eventDetails = '/event_details';
  static const String createContacts = '/create_contact';
static const String editProfile = "/edit_profile";
static const String EventPreview= "/event_preview";
static const String realEventDetails= "/real_event_details";
  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    layout: (context) => LayoutView(),
    onBoarding: (context) => OnboardingScreen(),
    login: (context) => LoginView(),
    register: (context) => RegisterView(),
    addEvent: (context) => AddEventView(),
    eventDetails: (context) => EventDetailsView(),
    createContacts: (context) => CreateContact(),
    editProfile: (context) => EditProfile(),
    EventPreview: (context) => const EventPreviewPage(),
    realEventDetails :(context) => const RealEventDetails(),
  };
}
