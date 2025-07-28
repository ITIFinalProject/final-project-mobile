// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get hello => 'Hello Dylan!';

  @override
  String get now_set =>
      'Now that you are all set.\nLet\'s make your events extraordinary,\nstarting right here!';

  @override
  String get plan_event => 'Plan an Event';

  @override
  String get invitations => 'Invitations';

  @override
  String get no_invitations => 'No Invitations';

  @override
  String get no_invitations_desc =>
      'No invitations received? Take charge and plan your own event with EventJoy. It\'s easy and fun!';

  @override
  String get upcoming_events => 'Upcoming Events';

  @override
  String get no_events => 'No Events';

  @override
  String get no_events_desc =>
      'Your event calendar is a blank canvas. Use EventJoy to paint it with memorable moments.';

  @override
  String get change_theme => 'Change Theme';

  @override
  String get change_language => 'Change Language';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get notification => 'Notification';

  @override
  String get contact_us => 'Contact Us';

  @override
  String get sign_out => 'Sign Out';
}
