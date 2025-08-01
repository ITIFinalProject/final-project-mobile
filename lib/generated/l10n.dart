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

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Entertainment`
  String get entertainment {
    return Intl.message(
      'Entertainment',
      name: 'entertainment',
      desc: '',
      args: [],
    );
  }

  /// `Educational & Business`
  String get educationalAndbusiness {
    return Intl.message(
      'Educational & Business',
      name: 'educationalAndbusiness',
      desc: '',
      args: [],
    );
  }

  /// `Cultural & Arts`
  String get culturalAndarts {
    return Intl.message(
      'Cultural & Arts',
      name: 'culturalAndarts',
      desc: '',
      args: [],
    );
  }

  /// `Sports & Fitness`
  String get sportsAndfitness {
    return Intl.message(
      'Sports & Fitness',
      name: 'sportsAndfitness',
      desc: '',
      args: [],
    );
  }

  /// `Technology & Innovation`
  String get technologyAndinnovation {
    return Intl.message(
      'Technology & Innovation',
      name: 'technologyAndinnovation',
      desc: '',
      args: [],
    );
  }

  /// `Travel & Adventure`
  String get travelAndadventure {
    return Intl.message(
      'Travel & Adventure',
      name: 'travelAndadventure',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message('Events', name: 'events', desc: '', args: []);
  }

  /// `No Events`
  String get no_events {
    return Intl.message('No Events', name: 'no_events', desc: '', args: []);
  }

  /// `Update Event`
  String get update_event {
    return Intl.message(
      'Update Event',
      name: 'update_event',
      desc: '',
      args: [],
    );
  }

  /// `Create Event`
  String get create_event {
    return Intl.message(
      'Create Event',
      name: 'create_event',
      desc: '',
      args: [],
    );
  }

  /// `Customize`
  String get customize {
    return Intl.message('Customize', name: 'customize', desc: '', args: []);
  }

  /// `Your Event Cover Here`
  String get your_event_cover_here {
    return Intl.message(
      'Your Event Cover Here',
      name: 'your_event_cover_here',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get upload_image {
    return Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `Choose Template`
  String get choose_template {
    return Intl.message(
      'Choose Template',
      name: 'choose_template',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message('Messages', name: 'messages', desc: '', args: []);
  }

  /// `No joined events yet`
  String get no_joined_events_yet {
    return Intl.message(
      'No joined events yet',
      name: 'no_joined_events_yet',
      desc: '',
      args: [],
    );
  }

  /// `Next : Event Details`
  String get next_event_details {
    return Intl.message(
      'Next : Event Details',
      name: 'next_event_details',
      desc: '',
      args: [],
    );
  }

  /// `2 of 5 : Event Details`
  String get step_2_of_5_event_details {
    return Intl.message(
      '2 of 5 : Event Details',
      name: 'step_2_of_5_event_details',
      desc: '',
      args: [],
    );
  }

  /// `Event Title`
  String get event_title {
    return Intl.message('Event Title', name: 'event_title', desc: '', args: []);
  }

  /// `Enter event title`
  String get enter_event_title {
    return Intl.message(
      'Enter event title',
      name: 'enter_event_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your event title`
  String get please_enter_your_event_title {
    return Intl.message(
      'Please enter your event title',
      name: 'please_enter_your_event_title',
      desc: '',
      args: [],
    );
  }

  /// `Event Category`
  String get event_category {
    return Intl.message(
      'Event Category',
      name: 'event_category',
      desc: '',
      args: [],
    );
  }

  /// `Select event category`
  String get select_event_category {
    return Intl.message(
      'Select event category',
      name: 'select_event_category',
      desc: '',
      args: [],
    );
  }

  /// `Event Description`
  String get event_description {
    return Intl.message(
      'Event Description',
      name: 'event_description',
      desc: '',
      args: [],
    );
  }

  /// `Write your event description`
  String get write_your_event_description {
    return Intl.message(
      'Write your event description',
      name: 'write_your_event_description',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your event description`
  String get please_enter_your_event_description {
    return Intl.message(
      'Please enter your event description',
      name: 'please_enter_your_event_description',
      desc: '',
      args: [],
    );
  }

  /// `Event Type`
  String get event_type {
    return Intl.message('Event Type', name: 'event_type', desc: '', args: []);
  }

  /// `Select event type`
  String get select_event_type {
    return Intl.message(
      'Select event type',
      name: 'select_event_type',
      desc: '',
      args: [],
    );
  }

  /// `Please select your event type`
  String get please_select_event_type {
    return Intl.message(
      'Please select your event type',
      name: 'please_select_event_type',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message('Private', name: 'private', desc: '', args: []);
  }

  /// `Public`
  String get public {
    return Intl.message('Public', name: 'public', desc: '', args: []);
  }

  /// `Event Timing`
  String get event_timing {
    return Intl.message(
      'Event Timing',
      name: 'event_timing',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get start_date {
    return Intl.message('Start Date', name: 'start_date', desc: '', args: []);
  }

  /// `Start Time`
  String get start_time {
    return Intl.message('Start Time', name: 'start_time', desc: '', args: []);
  }

  /// `End Date`
  String get end_date {
    return Intl.message('End Date', name: 'end_date', desc: '', args: []);
  }

  /// `End Time`
  String get end_time {
    return Intl.message('End Time', name: 'end_time', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Open Google maps`
  String get open_google_maps {
    return Intl.message(
      'Open Google maps',
      name: 'open_google_maps',
      desc: '',
      args: [],
    );
  }

  /// `Attendees`
  String get attendees {
    return Intl.message('Attendees', name: 'attendees', desc: '', args: []);
  }

  /// `Enter number of attendees`
  String get enter_number_of_attendees {
    return Intl.message(
      'Enter number of attendees',
      name: 'enter_number_of_attendees',
      desc: '',
      args: [],
    );
  }

  /// `Hosted By`
  String get hosted_by {
    return Intl.message('Hosted By', name: 'hosted_by', desc: '', args: []);
  }

  /// `Enter host name`
  String get enter_host_name {
    return Intl.message(
      'Enter host name',
      name: 'enter_host_name',
      desc: '',
      args: [],
    );
  }

  /// `Next : Preview`
  String get next_preview {
    return Intl.message(
      'Next : Preview',
      name: 'next_preview',
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

  /// `Recommended Events`
  String get recommended_events {
    return Intl.message(
      'Recommended Events',
      name: 'recommended_events',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Create an event and make some memories.`
  String get no_events_desc {
    return Intl.message(
      'Create an event and make some memories.',
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

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Save Changes`
  String get save_changes {
    return Intl.message(
      'Save Changes',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Profile Updated Successfully`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile Updated Successfully',
      name: 'profile_updated_successfully',
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

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Verify Password`
  String get verify_password {
    return Intl.message(
      'Verify Password',
      name: 'verify_password',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Enter Old Password`
  String get enter_old_password1 {
    return Intl.message(
      'Enter Old Password',
      name: 'enter_old_password1',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Password Updated Successfully`
  String get password_updated_successfully {
    return Intl.message(
      'Password Updated Successfully',
      name: 'password_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Save Password`
  String get save_password {
    return Intl.message(
      'Save Password',
      name: 'save_password',
      desc: '',
      args: [],
    );
  }

  /// `My Events`
  String get my_events {
    return Intl.message('My Events', name: 'my_events', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Event Memories`
  String get event_memories {
    return Intl.message(
      'Event Memories',
      name: 'event_memories',
      desc: '',
      args: [],
    );
  }

  /// `No ended events yet`
  String get no_ended_events_yet {
    return Intl.message(
      'No ended events yet',
      name: 'no_ended_events_yet',
      desc: '',
      args: [],
    );
  }

  /// `No user data found`
  String get no_user_data_found {
    return Intl.message(
      'No user data found',
      name: 'no_user_data_found',
      desc: 'Shown when user data is not available',
      args: [],
    );
  }

  /// `Take a photo`
  String get take_a_photo {
    return Intl.message(
      'Take a photo',
      name: 'take_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `Choose from gallery`
  String get choose_from_gallery {
    return Intl.message(
      'Choose from gallery',
      name: 'choose_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `No events found in this category`
  String get no_events_found_in_this_category {
    return Intl.message(
      'No events found in this category',
      name: 'no_events_found_in_this_category',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message('Join', name: 'join', desc: '', args: []);
  }

  /// `Ask Ai about anything`
  String get ask_ai_about_anything {
    return Intl.message(
      'Ask Ai about anything',
      name: 'ask_ai_about_anything',
      desc: '',
      args: [],
    );
  }

  /// `AI Chat`
  String get ai_chat {
    return Intl.message('AI Chat', name: 'ai_chat', desc: '', args: []);
  }

  /// `Write your message here`
  String get write_your_message_here {
    return Intl.message(
      'Write your message here',
      name: 'write_your_message_here',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get no_results_found {
    return Intl.message(
      'No results found',
      name: 'no_results_found',
      desc: '',
      args: [],
    );
  }

  /// `You need to be logged in to access the chat`
  String get login_required_message {
    return Intl.message(
      'You need to be logged in to access the chat',
      name: 'login_required_message',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `No messages yet`
  String get no_messages_yet {
    return Intl.message(
      'No messages yet',
      name: 'no_messages_yet',
      desc: '',
      args: [],
    );
  }

  /// `Write a message...`
  String get write_a_message {
    return Intl.message(
      'Write a message...',
      name: 'write_a_message',
      desc: '',
      args: [],
    );
  }

  /// `Send a message to your guests`
  String get send_a_message_to_your_guests {
    return Intl.message(
      'Send a message to your guests',
      name: 'send_a_message_to_your_guests',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your old password`
  String get enter_old_password {
    return Intl.message(
      'Please enter your old password',
      name: 'enter_old_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_min_length {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password. Try again.`
  String get wrong_password {
    return Intl.message(
      'Wrong password. Try again.',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `1 of 5: Customize`
  String get customize_step_title {
    return Intl.message(
      '1 of 5: Customize',
      name: 'customize_step_title',
      desc: '',
      args: [],
    );
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
