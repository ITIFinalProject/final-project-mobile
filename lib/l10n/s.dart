import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 's_ar.dart';
import 's_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/s.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @educationalAndbusiness.
  ///
  /// In en, this message translates to:
  /// **'Educational & Business'**
  String get educationalAndbusiness;

  /// No description provided for @culturalAndarts.
  ///
  /// In en, this message translates to:
  /// **'Cultural & Arts'**
  String get culturalAndarts;

  /// No description provided for @sportsAndfitness.
  ///
  /// In en, this message translates to:
  /// **'Sports & Fitness'**
  String get sportsAndfitness;

  /// No description provided for @technologyAndinnovation.
  ///
  /// In en, this message translates to:
  /// **'Technology & Innovation'**
  String get technologyAndinnovation;

  /// No description provided for @travelAndadventure.
  ///
  /// In en, this message translates to:
  /// **'Travel & Adventure'**
  String get travelAndadventure;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @edit_event.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get edit_event;

  /// No description provided for @event_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Event Updated Successfully'**
  String get event_updated_successfully;

  /// No description provided for @end_datetime_must_be_after_start_datetime.
  ///
  /// In en, this message translates to:
  /// **'End date/time must be after start date/time'**
  String get end_datetime_must_be_after_start_datetime;

  /// No description provided for @no_events.
  ///
  /// In en, this message translates to:
  /// **'No Events'**
  String get no_events;

  /// No description provided for @start_text.
  ///
  /// In en, this message translates to:
  /// **'Start: {start}'**
  String start_text(Object start);

  /// No description provided for @please_enter_number_of_attendees.
  ///
  /// In en, this message translates to:
  /// **'Please enter number of attendees'**
  String get please_enter_number_of_attendees;

  /// No description provided for @please_enter_host_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter host name'**
  String get please_enter_host_name;

  /// No description provided for @no_created_events.
  ///
  /// In en, this message translates to:
  /// **'You haven’t created any events yet.'**
  String get no_created_events;

  /// No description provided for @no_events_created.
  ///
  /// In en, this message translates to:
  /// **'No Events Created'**
  String get no_events_created;

  /// No description provided for @confirm_delete_event.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this event?'**
  String get confirm_delete_event;

  /// No description provided for @delete_event.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get delete_event;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @interestedEvents.
  ///
  /// In en, this message translates to:
  /// **'Interested Events'**
  String get interestedEvents;

  /// No description provided for @joinedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Joined Successfully'**
  String get joinedSuccessfully;

  /// No description provided for @noInterestedEvents.
  ///
  /// In en, this message translates to:
  /// **'No interested events yet.'**
  String get noInterestedEvents;

  /// No description provided for @eventDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Event Deleted Successfully'**
  String get eventDeletedSuccessfully;

  /// No description provided for @update_event.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get update_event;

  /// No description provided for @create_event.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get create_event;

  /// No description provided for @customize.
  ///
  /// In en, this message translates to:
  /// **'Customize'**
  String get customize;

  /// No description provided for @your_event_cover_here.
  ///
  /// In en, this message translates to:
  /// **'Your Event Cover Here'**
  String get your_event_cover_here;

  /// No description provided for @upload_image.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get upload_image;

  /// No description provided for @choose_template.
  ///
  /// In en, this message translates to:
  /// **'Choose Template'**
  String get choose_template;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @no_joined_events_yet.
  ///
  /// In en, this message translates to:
  /// **'No joined events yet'**
  String get no_joined_events_yet;

  /// No description provided for @next_event_details.
  ///
  /// In en, this message translates to:
  /// **'Next : Event Details'**
  String get next_event_details;

  /// No description provided for @step_2_of_5_event_details.
  ///
  /// In en, this message translates to:
  /// **'2 of 5 : Event Details'**
  String get step_2_of_5_event_details;

  /// No description provided for @event_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_title;

  /// No description provided for @enter_event_title.
  ///
  /// In en, this message translates to:
  /// **'Enter event title'**
  String get enter_event_title;

  /// No description provided for @please_enter_your_event_title.
  ///
  /// In en, this message translates to:
  /// **'Please enter your event title'**
  String get please_enter_your_event_title;

  /// No description provided for @event_category.
  ///
  /// In en, this message translates to:
  /// **'Event Category'**
  String get event_category;

  /// No description provided for @select_event_category.
  ///
  /// In en, this message translates to:
  /// **'Select event category'**
  String get select_event_category;

  /// No description provided for @pleaseselect_event_category.
  ///
  /// In en, this message translates to:
  /// **'Please Select event category'**
  String get pleaseselect_event_category;

  /// No description provided for @event_description.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get event_description;

  /// No description provided for @write_your_event_description.
  ///
  /// In en, this message translates to:
  /// **'Write your event description'**
  String get write_your_event_description;

  /// No description provided for @please_enter_your_event_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter your event description'**
  String get please_enter_your_event_description;

  /// No description provided for @event_type.
  ///
  /// In en, this message translates to:
  /// **'Event Type'**
  String get event_type;

  /// No description provided for @select_event_type.
  ///
  /// In en, this message translates to:
  /// **'Select event type'**
  String get select_event_type;

  /// No description provided for @please_select_event_type.
  ///
  /// In en, this message translates to:
  /// **'Please select your event type'**
  String get please_select_event_type;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @pick_location.
  ///
  /// In en, this message translates to:
  /// **'Pick Location'**
  String get pick_location;

  /// No description provided for @event_timing.
  ///
  /// In en, this message translates to:
  /// **'Event Timing'**
  String get event_timing;

  /// No description provided for @addguests.
  ///
  /// In en, this message translates to:
  /// **'4 of 5: Add Guests'**
  String get addguests;

  /// No description provided for @start_date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get start_date;

  /// No description provided for @start_time.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get start_time;

  /// No description provided for @search_contacts.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get search_contacts;

  /// No description provided for @no_number.
  ///
  /// In en, this message translates to:
  /// **'No number'**
  String get no_number;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get see_all;

  /// No description provided for @next_review_send.
  ///
  /// In en, this message translates to:
  /// **'Next: Review & Send'**
  String get next_review_send;

  /// No description provided for @invitations_sent.
  ///
  /// In en, this message translates to:
  /// **'Invitations sent successfully'**
  String get invitations_sent;

  /// No description provided for @create_contact.
  ///
  /// In en, this message translates to:
  /// **'Create Contact'**
  String get create_contact;

  /// No description provided for @guest_email.
  ///
  /// In en, this message translates to:
  /// **'Guest Email'**
  String get guest_email;

  /// No description provided for @capacity_reached.
  ///
  /// In en, this message translates to:
  /// **'Capacity reached'**
  String get capacity_reached;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @please_add_one_guest.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one guest'**
  String get please_add_one_guest;

  /// No description provided for @no_valid_users_found.
  ///
  /// In en, this message translates to:
  /// **'No valid registered users found.'**
  String get no_valid_users_found;

  /// No description provided for @error_fetching_guest_data.
  ///
  /// In en, this message translates to:
  /// **'Error fetching guest data'**
  String get error_fetching_guest_data;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @failed_to_create_event.
  ///
  /// In en, this message translates to:
  /// **'Failed to create event'**
  String get failed_to_create_event;

  /// No description provided for @event_details_step.
  ///
  /// In en, this message translates to:
  /// **'2 of 5: Event Details'**
  String get event_details_step;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get end_date;

  /// No description provided for @please_enter_your_start_date.
  ///
  /// In en, this message translates to:
  /// **'please enter your start date'**
  String get please_enter_your_start_date;

  /// No description provided for @please_enter_your_end_date.
  ///
  /// In en, this message translates to:
  /// **'please enter your end date'**
  String get please_enter_your_end_date;

  /// No description provided for @please_enter_your_start_time.
  ///
  /// In en, this message translates to:
  /// **'please enter your start time'**
  String get please_enter_your_start_time;

  /// No description provided for @please_enter_your_end_time.
  ///
  /// In en, this message translates to:
  /// **'please enter your end time'**
  String get please_enter_your_end_time;

  /// No description provided for @yyyymmdd.
  ///
  /// In en, this message translates to:
  /// **'yyyy-MM-dd'**
  String get yyyymmdd;

  /// No description provided for @end_time.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get end_time;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @enter_event_location.
  ///
  /// In en, this message translates to:
  /// **'Enter Event Location'**
  String get enter_event_location;

  /// No description provided for @please_enter_your_event_location.
  ///
  /// In en, this message translates to:
  /// **'Please enter your event Location'**
  String get please_enter_your_event_location;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @select_category.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get select_category;

  /// No description provided for @please_select_category.
  ///
  /// In en, this message translates to:
  /// **'Please select category'**
  String get please_select_category;

  /// No description provided for @open_google_maps.
  ///
  /// In en, this message translates to:
  /// **'Open Google maps'**
  String get open_google_maps;

  /// No description provided for @attendees.
  ///
  /// In en, this message translates to:
  /// **'Attendees'**
  String get attendees;

  /// No description provided for @enter_number_of_attendees.
  ///
  /// In en, this message translates to:
  /// **'Enter number of attendees'**
  String get enter_number_of_attendees;

  /// No description provided for @hosted_by.
  ///
  /// In en, this message translates to:
  /// **'Hosted By'**
  String get hosted_by;

  /// No description provided for @enter_host_name.
  ///
  /// In en, this message translates to:
  /// **'Enter host name'**
  String get enter_host_name;

  /// No description provided for @next_preview.
  ///
  /// In en, this message translates to:
  /// **'Next : Preview'**
  String get next_preview;

  /// No description provided for @upcoming_events.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Events'**
  String get upcoming_events;

  /// No description provided for @recommended_events.
  ///
  /// In en, this message translates to:
  /// **'Recommended Events'**
  String get recommended_events;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @no_events_desc.
  ///
  /// In en, this message translates to:
  /// **'Create an event and make some memories.'**
  String get no_events_desc;

  /// No description provided for @change_theme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get change_theme;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @profile_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile Updated Successfully'**
  String get profile_updated_successfully;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @verify_password.
  ///
  /// In en, this message translates to:
  /// **'Verify Password'**
  String get verify_password;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @enter_old_password1.
  ///
  /// In en, this message translates to:
  /// **'Enter Old Password'**
  String get enter_old_password1;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @password_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password Updated Successfully'**
  String get password_updated_successfully;

  /// No description provided for @save_password.
  ///
  /// In en, this message translates to:
  /// **'Save Password'**
  String get save_password;

  /// No description provided for @my_events.
  ///
  /// In en, this message translates to:
  /// **'My Events'**
  String get my_events;

  /// No description provided for @capacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// No description provided for @please_enter_capacity.
  ///
  /// In en, this message translates to:
  /// **'Please enter capacity'**
  String get please_enter_capacity;

  /// No description provided for @enter_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Enter valid number'**
  String get enter_valid_number;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @event_memories.
  ///
  /// In en, this message translates to:
  /// **'Event Memories'**
  String get event_memories;

  /// No description provided for @no_ended_events_yet.
  ///
  /// In en, this message translates to:
  /// **'No ended events yet'**
  String get no_ended_events_yet;

  /// Shown when user data is not available
  ///
  /// In en, this message translates to:
  /// **'No user data found'**
  String get no_user_data_found;

  /// No description provided for @take_a_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get take_a_photo;

  /// No description provided for @choose_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get choose_from_gallery;

  /// No description provided for @no_events_found_in_this_category.
  ///
  /// In en, this message translates to:
  /// **'No events found in this category'**
  String get no_events_found_in_this_category;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @ask_ai_about_anything.
  ///
  /// In en, this message translates to:
  /// **'Ask Ai about anything'**
  String get ask_ai_about_anything;

  /// No description provided for @ai_chat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get ai_chat;

  /// No description provided for @write_your_message_here.
  ///
  /// In en, this message translates to:
  /// **'Write your message here'**
  String get write_your_message_here;

  /// No description provided for @no_results_found.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get no_results_found;

  /// No description provided for @login_required_message.
  ///
  /// In en, this message translates to:
  /// **'You need to be logged in to access the chat'**
  String get login_required_message;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @no_messages_yet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get no_messages_yet;

  /// No description provided for @write_a_message.
  ///
  /// In en, this message translates to:
  /// **'Write a message...'**
  String get write_a_message;

  /// No description provided for @send_a_message_to_your_guests.
  ///
  /// In en, this message translates to:
  /// **'Send a message to your guests'**
  String get send_a_message_to_your_guests;

  /// No description provided for @enter_old_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your old password'**
  String get enter_old_password;

  /// No description provided for @password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_min_length;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong password. Try again.'**
  String get wrong_password;

  /// No description provided for @customize_step_title.
  ///
  /// In en, this message translates to:
  /// **'1 of 5: Customize'**
  String get customize_step_title;

  /// No description provided for @createEventAndMakeMemories.
  ///
  /// In en, this message translates to:
  /// **'Create an event and make some memories'**
  String get createEventAndMakeMemories;

  /// No description provided for @noEventsForThatDay.
  ///
  /// In en, this message translates to:
  /// **'No Events for that Day'**
  String get noEventsForThatDay;

  /// No description provided for @eventMemories.
  ///
  /// In en, this message translates to:
  /// **'Event Memories'**
  String get eventMemories;

  /// No description provided for @noEndedEventsYet.
  ///
  /// In en, this message translates to:
  /// **'No ended events yet.'**
  String get noEndedEventsYet;

  /// No description provided for @eventMemory.
  ///
  /// In en, this message translates to:
  /// **'Event Memory'**
  String get eventMemory;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'en':
      return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
