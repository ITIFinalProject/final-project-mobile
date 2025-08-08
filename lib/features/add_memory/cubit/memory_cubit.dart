import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/add_memory/models/memory_model.dart';
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

      final response = await supabase.storage
          .from('memories')
          .uploadBinary(filePath, fileBytes ,fileOptions: FileOptions(
        contentType: type=='image'?'image/jpeg' : 'video/mp4'
      ));

      if (response.isEmpty) {
        throw Exception("Upload to Supabase failed");
      }

      final publicUrl = supabase.storage
          .from('memories')
          .getPublicUrl(filePath);

      print('Done uploading to Supabase: $publicUrl');

      final memoryRef = await firestore
          .collection('events')
          .doc(eventId)
          .collection('memories')
          .add({
        'url': publicUrl,
        'type': type,
        'id': '',
        'createdAt': FieldValue.serverTimestamp()
      });
      await memoryRef.update({'id': memoryRef.id});
      print('Done uploading to Firestore');
      emit(MemoryUploaded());

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

      final memories = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return MemoryModel.fromMap(data);
      }).toList();

      emit(MemoriesLoaded(memories));
    } catch (e) {
      emit(MemoryError(e.toString()));
    }
  }

  Future<void> deleteMemory({
    required String eventId,
    required String memoryId,
    required String fileUrl,
  }) async {
    emit(MemoryLoading());

    try {
      final storagePath = _getStoragePathFromUrl(fileUrl);
      await supabase.storage.from('memories').remove([storagePath]);


      await firestore
          .collection('events')
          .doc(eventId)
          .collection('memories')
          .doc(memoryId)
          .delete();

      log("✅ Memory deleted successfully");
      final snapshot = await firestore
          .collection('events')
          .doc(eventId)
          .collection('memories')
          .get();

      final memories = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return MemoryModel.fromMap(data);
      }).toList();
      emit(MemoriesLoaded(memories));
    } catch (e) {
      log("❌ Error deleting memory: $e");
      emit(MemoryError("Failed to delete memory: $e"));
    }
  }

  String _getStoragePathFromUrl(String url) {
    final uri = Uri.parse(url);
    final index = uri.path.indexOf('/memories/');
    if (index == -1) return '';
    return uri.path.substring(index + '/memories/'.length);
  }

}
