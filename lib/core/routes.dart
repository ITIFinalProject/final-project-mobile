import 'package:eventify_app/features/add_event/add_event_view.dart';
import 'package:eventify_app/features/add_event/create_contact.dart';
import 'package:eventify_app/features/add_event/event_details_view.dart';
import 'package:eventify_app/features/add_event/widgets/map_location.dart';
import 'package:eventify_app/features/auth/view/login.dart';
import 'package:eventify_app/features/auth/view/register.dart';
import 'package:eventify_app/features/auth/view/widgets/forget_password_view.dart';
import 'package:eventify_app/features/layout/layout.dart';
import 'package:eventify_app/features/onboarding/onboarding_screen.dart';
import 'package:eventify_app/features/profile/change%20password/verify_old_pass.dart';
import 'package:eventify_app/features/profile/edit_profile.dart';
import 'package:eventify_app/features/profile/profile_view.dart';
import 'package:eventify_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../features/add_event/add_guest.dart';
import '../features/events/event_details.dart';
import '../features/events/evevnt_preview.dart';

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
  static const String eventPreview = "/event_preview";
  static const String realEventDetails = "/real_event_details";
  static const String addGuest = '/add_guest';
  static const String forgetPassword = '/forget_password';
  static const String mapPicker = '/map_picker';
  static const String verifyOldPassword = '/verify_old_password';
  static const String profileView = '/profile_view';
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
    addGuest: (context) => AddGuests(),
    eventPreview: (context) => const EventPreviewPage(),
    realEventDetails: (context) => const RealEventDetails(),
    forgetPassword: (context) => ForgetPasswordView(),
    mapPicker: (context) => MapPickerScreen(),
    verifyOldPassword: (context) => VerifyOldPass(),
    profileView: (context) => ProfileView(),
  };
}
