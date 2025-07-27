import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/models.dart/event_model.dart' show EventModel;
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
        final fileExt = imageFile.path
            .split('.')
            .last;
        final filePath = 'public/$eventId.$fileExt';

        final fileBytes = await imageFile.readAsBytes();

        final storageResponse = await supabase.storage
            .from('event-images')
            .uploadBinary(filePath, fileBytes,
            fileOptions: FileOptions(contentType: 'image/$fileExt'));

        imageUrl = supabase.storage
            .from('event-images')
            .getPublicUrl(filePath);
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
      );

      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .set(newEvent.toMap());

      print('✅ Event saved successfully to Firestore!');
      emit(CreateEventSuccess(newEvent));
    } catch (e, stackTrace) {
      print('❌ Error creating event: $e');
      print('🔍 StackTrace: $stackTrace');
      emit(CreateEventError(e.toString()));
    }
  }
}
