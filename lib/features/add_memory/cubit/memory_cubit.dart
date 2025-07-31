import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/add_memory/models/memory_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'memory_state.dart';

class MemoryCubit extends Cubit<MemoryState> {
  MemoryCubit() : super(MemoryInitial());

  final supabase = Supabase.instance.client;
  final firestore = FirebaseFirestore.instance;

  Future<void> uploadMemory({
    required String type, // 'image' or 'video'
    required File file,
    required String eventId,
  }) async {
    emit(MemoryLoading());
    print('Uploading memory...');

    try {
      final fileBytes = await file.readAsBytes();
      final fileExt = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = 'events/$eventId/$fileName';

      // ✅ رفع الملف باستخدام uploadBinary
      final response = await supabase.storage
          .from('memories')
          .uploadBinary(filePath, fileBytes);

      if (response.isEmpty) {
        throw Exception("Upload to Supabase failed");
      }

      // ✅ الحصول على رابط الملف
      final publicUrl = supabase.storage
          .from('memories')
          .getPublicUrl(filePath);

      print('Done uploading to Supabase: $publicUrl');

      // ✅ حفظ الرابط في Firestore
      await firestore
          .collection('events')
          .doc(eventId)
          .collection('memories')
          .add({
        'url': publicUrl,
        'type': type,
      });

      print('Done uploading to Firestore');
      emit(MemoryUploaded());

      // ✅ تحديث الذكريات بعد الرفع
      await fetchMemories(eventId);
    } catch (e, stackTrace) {
      print('Error uploading memory: $e');
      print(stackTrace);
      emit(MemoryError(e.toString()));
    }
  }

  Future<void> fetchMemories(String eventId) async {
    emit(MemoryLoading());

    try {
      final snapshot = await firestore
          .collection('events')
          .doc(eventId)
          .collection('memories')
          .get();

      final memories = snapshot.docs.map((doc) => MemoryModel.fromMap(doc.data())).toList();

      emit(MemoriesLoaded(memories));
    } catch (e) {
      emit(MemoryError(e.toString()));
    }
  }
}
