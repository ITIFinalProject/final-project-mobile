import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/models.dart/Event_model.dart' show EventModel;
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventInitial());

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
    required String hosteName,
  }) async {
    emit(CreateEventLoading());

    try {
      print('✅ Starting event creation...');
      final String eventId = const Uuid().v4();

      // رفع الصورة لو تم اختيارها
      // String imageUrl = '';
      // if (imageFile != null) {
      //   print('📤 Uploading image to Firebase Storage...');
      //   final storageRef = FirebaseStorage.instance
      //       .ref()
      //       .child('events')
      //       .child('$eventId.jpg');

      //   await storageRef.putFile(imageFile);
      //   imageUrl = await storageRef.getDownloadURL();
      //   print('✅ Image uploaded successfully: $imageUrl');
      // } else {
      //   print('ℹ No image selected, continuing without image.');
      // }

      // تجهيز الموديل
      final newEvent = EventModel(
        id: eventId,
        title: title,
        type: type, // ✅ هنا لازم نحط النوع اللي جاي من الفورم
        description: description,
        date: date,
        time: time,
        location: location,
        capacity: capacity,
        // image: imageUrl,
        // templateIndex: templateIndex ?? 1,
        hosteName: hosteName, // ✅ هنا نحط الـ host الحقيقي
      );

      print('📝 Saving event to Firestore...');
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
