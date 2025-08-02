// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventify_app/models.dart/event_model.dart' show EventModel;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uuid/uuid.dart';

// part 'create_event_state.dart';

// class CreateEventCubit extends Cubit<CreateEventState> {
//   CreateEventCubit() : super(CreateEventInitial());
//   final supabase = Supabase.instance.client;

//   Future<void> createEvent({
//     required String title,
//     required String type,
//     required String description,
//     required String date,
//     required String time,
//     required String location,
//     required int capacity,
//     File? imageFile,
//     int? templateIndex,
//     required String hostName,
//     required String category
//   }) async {
//     emit(CreateEventLoading());

//     try {
//       print('✅ Starting event creation...');
//       final String eventId = const Uuid().v4();

//       String? imageUrl;
//       if (imageFile != null) {
//         final fileExt = imageFile.path.split('.').last;
//         final filePath = 'public/$eventId.$fileExt';

//         final fileBytes = await imageFile.readAsBytes();

//         final storageResponse = await supabase.storage
//             .from('event-images')
//             .uploadBinary(
//               filePath,
//               fileBytes,
//               fileOptions: FileOptions(contentType: 'image/$fileExt'),
//             );

//         imageUrl = supabase.storage.from('event-images').getPublicUrl(filePath);
//       }
//       final newEvent = EventModel(
//         id: eventId,
//         title: title,
//         type: type,
//         description: description,
//         date: date,
//         time: time,
//         location: location,
//         capacity: capacity,
//         bannerUrl: imageUrl,
//         templateIndex: templateIndex,
//         hostName: hostName,
//         category: category,
//         hostId: FirebaseAuth.instance.currentUser!.uid
//       );

//       await FirebaseFirestore.instance
//           .collection('events')
//           .doc(eventId)
//           .set(newEvent.toMap());

//       print('✅ Event saved successfully to Firestore!');
//       emit(CreateEventSuccess(newEvent));
//     } catch (e, stackTrace) {
//       print('Error creating event: $e');
//       print('StackTrace: $stackTrace');
//       emit(CreateEventError(e.toString()));
//     }
//   }

//   Future<void> updateEvent({
//     required String eventId,
//     required String title,
//     required String type,
//     required String description,
//     required String date,
//     required String time,
//     required String location,
//     required int capacity,
//     required String category,
//     File? imageFile,
//     int? templateIndex,
//     required String hostName,
//   }) async {
//     emit(CreateEventLoading());
//     try {
//       print(' Starting event update...');

//       String? imageUrl;
//       if (imageFile != null) {
//         final fileExt = imageFile.path
//             .split('.')
//             .last;
//         final filePath = 'public/$eventId.$fileExt';

//         final fileBytes = await imageFile.readAsBytes();

//         await supabase.storage.from('event-images').uploadBinary(
//           filePath,
//           fileBytes,
//           fileOptions: FileOptions(contentType: 'image/$fileExt'),
//         );

//         imageUrl = supabase.storage.from('event-images').getPublicUrl(filePath);
//       }

//       final updateData = {
//         'title': title,
//         'type': type,
//         'description': description,
//         'date': date,
//         'time': time,
//         'location': location,
//         'capacity': capacity,
//         'templateIndex': templateIndex,
//         'hostName': hostName,
//       };

//       if (imageUrl != null) {
//         updateData['image'] = imageUrl;
//       }

//       await FirebaseFirestore.instance.collection('events').doc(eventId).update(
//           updateData);

//       final updatedEvent = EventModel(
//         id: eventId,
//         title: title,
//         type: type,
//         description: description,
//         date: date,
//         time: time,
//         location: location,
//         capacity: capacity,
//         bannerUrl: imageUrl,
//         templateIndex: templateIndex,
//         hostName: hostName,
//         category: category,
//         hostId: FirebaseAuth.instance.currentUser?.uid ?? '',
//       );

//       print('✅ Event updated successfully!');
//       emit(CreateEventSuccess(updatedEvent));
//     } catch (e, stackTrace) {
//       print('❌ Error updating event: $e');
//       print('🔍 StackTrace: $stackTrace');
//       emit(CreateEventError(e.toString()));
//     }
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/notication_service.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:eventify_app/models.dart/event_model.dart' show EventModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/fcm_service.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventInitial());
  final supabase = Supabase.instance.client;

  Future<void> createEvent({
    required String title,
    required String type,
    required String description,
    required String date,
    required String time,
    required String location,
    required int capacity,
    File? imageFile,
    int? templateIndex,
    required String hostName,
    required String category,
    List<UserModel>? guests
  }) async {
    emit(CreateEventLoading());

    try {
      print('✅ Starting event creation...');
      final String eventId = const Uuid().v4();

      String? imageUrl;
      if (imageFile != null) {
        final fileExt = imageFile.path.split('.').last;
        final filePath = 'public/$eventId.$fileExt';

        final fileBytes = await imageFile.readAsBytes();

        final storageResponse = await supabase.storage
            .from('event-images')
            .uploadBinary(
              filePath,
              fileBytes,
              fileOptions: FileOptions(contentType: 'image/$fileExt'),
            );

        imageUrl = supabase.storage.from('event-images').getPublicUrl(filePath);
      }
      final newEvent = EventModel(
        id: eventId,
        title: title,
        type: type,
        description: description,
        date: date,
        time: time,
        location: location,
        capacity: capacity,
        bannerUrl: imageUrl,
        templateIndex: templateIndex,
        hostName: hostName,
        category: category,
        hostId: FirebaseAuth.instance.currentUser!.uid,
        guests: guests,

      );
      if (type.toLowerCase() == 'private' && guests != null && guests.isNotEmpty) {
        await sendPrivateInvitations(guests: guests, event: newEvent);
      }

      print('Guests: ${guests?.map((e) => e.name)}');
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .set(newEvent.toMap());

      print('✅ Event saved successfully to Firestore!');
      emit(CreateEventSuccess(newEvent));
    } catch (e, stackTrace) {
      print('Error creating event: $e');
      print('StackTrace: $stackTrace');
      emit(CreateEventError(e.toString()));
    }
  }
  Future<void> sendPrivateInvitations({
    required List<UserModel> guests,
    required EventModel event,
  }) async {
    for (final guest in guests) {
      if (guest.fcmToken != null && guest.fcmToken!.isNotEmpty) {
        // 1. Send FCM Notification
        await NotificationService().sendPushNotification(
          deviceToken: guest.fcmToken!,
          title: " You're Invited to ${event.title}! 🎉",
          body: "Don't miss the fun — check your invitation now.",
          data: {
            "eventId": event.id,
            "type": "event_invitation"
          }
        );
      }

      // 2. Save Notification in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(guest.uid)
          .collection('notifications')
          .add({
        'createdAt': FieldValue.serverTimestamp(),
        'eventId': event.id,
        'eventTitle': event.title,
        'eventDescription': event.description,
        'eventCategory': event.category,
        'eventLocation': event.location,
        'eventDate': event.date,
        'eventTime': event.time,
        'hostId': event.hostId,
        'hostName': event.hostName,
        'guestId': guest.uid,
        'guestEmail': guest.email,
        'type': 'invitation',
        'read': false,
        'status': 'pending',
      });
    }
  }

  Future<void> updateEvent({
    required String eventId,
    required String title,
    required String type,
    required String description,
    required String date,
    required String time,
    required String location,
    required int capacity,
    required String category,
    File? imageFile,
    int? templateIndex,
    required String hostName,
  }) async {
    emit(CreateEventLoading());
    try {
      print(' Starting event update...');

      String? imageUrl;
      if (imageFile != null) {
        final fileExt = imageFile.path
            .split('.')
            .last;
        final filePath = 'public/$eventId.$fileExt';

        final fileBytes = await imageFile.readAsBytes();

        await supabase.storage.from('event-images').uploadBinary(
          filePath,
          fileBytes,
          fileOptions: FileOptions(contentType: 'image/$fileExt'),
        );

        imageUrl = supabase.storage.from('event-images').getPublicUrl(filePath);
      }

      final updateData = {
        'title': title,
        'type': type,
        'description': description,
        'date': date,
        'time': time,
        'location': location,
        'capacity': capacity,
        'templateIndex': templateIndex,
        'hostName': hostName,
      };

      if (imageUrl != null) {
        updateData['image'] = imageUrl;
      }

      await FirebaseFirestore.instance.collection('events').doc(eventId).update(
          updateData);

      final updatedEvent = EventModel(
        id: eventId,
        title: title,
        type: type,
        description: description,
        date: date,
        time: time,
        location: location,
        capacity: capacity,
        bannerUrl: imageUrl,
        templateIndex: templateIndex,
        hostName: hostName,
        category: category,
        hostId: FirebaseAuth.instance.currentUser?.uid ?? '',
      );

      print('✅ Event updated successfully!');
      emit(CreateEventSuccess(updatedEvent));
    } catch (e, stackTrace) {
      print('❌ Error updating event: $e');
      print('🔍 StackTrace: $stackTrace');
      emit(CreateEventError(e.toString()));
    }
  }
}
