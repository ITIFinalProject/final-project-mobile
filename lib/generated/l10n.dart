// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Hello Dylan!`
  String get hello {
    return Intl.message('Hello Dylan!', name: 'hello', desc: '', args: []);
  }

  /// `Now that you are all set.\nLet's make your events extraordinary,\nstarting right here!`
  String get now_set {
    return Intl.message(
      'Now that you are all set.\nLet\'s make your events extraordinary,\nstarting right here!',
      name: 'now_set',
      desc: '',
      args: [],
    );
  }

  /// `Plan an Event`
  String get plan_event {
    return Intl.message(
      'Plan an Event',
      name: 'plan_event',
      desc: '',
      args: [],
    );
  }

  /// `Invitations`
  String get invitations {
    return Intl.message('Invitations', name: 'invitations', desc: '', args: []);
  }

  /// `No Invitations`
  String get no_invitations {
    return Intl.message(
      'No Invitations',
      name: 'no_invitations',
      desc: '',
      args: [],
    );
  }

  /// `No invitations received? Take charge and plan your own event with EventJoy. It's easy and fun!`
  String get no_invitations_desc {
    return Intl.message(
      'No invitations received? Take charge and plan your own event with EventJoy. It\'s easy and fun!',
      name: 'no_invitations_desc',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Events`
  String get upcoming_events {
    return Intl.message(
      'Upcoming Events',
      name: 'upcoming_events',
      desc: '',
      args: [],
    );
  }

  /// `No Events`
  String get no_events {
    return Intl.message('No Events', name: 'no_events', desc: '', args: []);
  }

  /// `Your event calendar is a blank canvas. Use EventJoy to paint it with memorable moments.`
  String get no_events_desc {
    return Intl.message(
      'Your event calendar is a blank canvas. Use EventJoy to paint it with memorable moments.',
      name: 'no_events_desc',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get change_theme {
    return Intl.message(
      'Change Theme',
      name: 'change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message('Sign Out', name: 'sign_out', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
