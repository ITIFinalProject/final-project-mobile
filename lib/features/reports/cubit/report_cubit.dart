import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/reports/cubit/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/report_model.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  final supabase = Supabase.instance.client;
  final firestore = FirebaseFirestore.instance;

  Future<void> submitReport({
    required ReportModel report,
    File? imageFile,
  }) async {
    emit(ReportSubmitting());

    try {
      String? imageUrl;

      // 1. Upload image if exists
      if (imageFile != null) {
        final fileName =
            'report-${report.eventId}-${DateTime.now().millisecondsSinceEpoch}.jpg';

        final storageResponse = await supabase.storage
            .from('event-images')
            .upload('public/$fileName', imageFile);

        imageUrl = supabase.storage
            .from('event-images')
            .getPublicUrl('public/$fileName');
      }

      // 2. Save to Firestore
      final fullReport = report.copyWith(evidenceImageUrl: imageUrl);

      await firestore.collection('reports').add(fullReport.toMap());

      emit(ReportSuccess());
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}
