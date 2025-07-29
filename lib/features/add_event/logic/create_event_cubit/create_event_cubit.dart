import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/models.dart/event_model.dart' show EventModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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
        image: imageUrl,
        templateIndex: templateIndex,
        hostName: hostName,
        hostId:FirebaseAuth.instance.currentUser?.uid ?? '', // Ensure hostId is set
      );

      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .set(newEvent.toMap());

      print('Event saved successfully to Firestore!');
      emit(CreateEventSuccess(newEvent));
    } catch (e, stackTrace) {
      print('Error creating event: $e');
      print('StackTrace: $stackTrace');
      emit(CreateEventError(e.toString()));
    }
  }
// ***************************************************************************************************
  Future<void> updateEvent({
  required String eventId,
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
}) async {
  emit(CreateEventLoading());
  try {
    print('✏️ Starting event update...');

    // ✅ لو في صورة جديدة نرفعها
    String? imageUrl;
    if (imageFile != null) {
      final fileExt = imageFile.path.split('.').last;
      final filePath = 'public/$eventId.$fileExt';

      final fileBytes = await imageFile.readAsBytes();

      await supabase.storage.from('event-images').uploadBinary(
        filePath,
        fileBytes,
        fileOptions: FileOptions(contentType: 'image/$fileExt'),
      );

      imageUrl = supabase.storage.from('event-images').getPublicUrl(filePath);
    }

    // ✅ نجهز الداتا اللي هتتحدث
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

    // ✅ تحديث Firestore
    await FirebaseFirestore.instance.collection('events').doc(eventId).update(updateData);

    // ✅ بناء EventModel جديد من البيانات بعد التحديث
    final updatedEvent = EventModel(
      id: eventId,
      title: title,
      type: type,
      description: description,
      date: date,
      time: time,
      location: location,
      capacity: capacity,
      image: imageUrl, // لو الصورة ما اتغيرتش هتكون null
      templateIndex: templateIndex,
      hostName: hostName,
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