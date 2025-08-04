import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/event_chat_messsage.dart';
import 'event_chat_state.dart';

class EventChatCubit extends Cubit<EventChatState> {
  final String eventId;
  final FirebaseFirestore firestore;
  StreamSubscription? _subscription;
  String? currentUserId;
  String? currentUserName;

  EventChatCubit({required this.eventId, required this.firestore})
    : super(EventChatInitial());

  void initializeUser({required String userId, required String userName}) {
    currentUserId = userId;
    currentUserName = userName;
  }

  void loadMessages() {
    emit(EventChatLoading());

    _subscription = firestore
        .collection('events')
        .doc(eventId)
        .collection('chats')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((snapshot) {
      final messages =
      snapshot.docs
          .where((doc) => doc.data().containsKey('createdAt'))
          .map((doc) => EventChatMessage.fromFireStore(doc))
          .toList();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final List readByList = data['readBy'] ?? [];
        final docId = doc.id;

        if (!readByList.contains(currentUserId)) {
          firestore
              .collection('events')
              .doc(eventId)
              .collection('chats')
              .doc(docId)
              .update({
            'readBy': FieldValue.arrayUnion([currentUserId])
          });
        }
      }
      emit(EventChatLoaded(messages));
        });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || currentUserId == null || currentUserName == null)
      return;

    await firestore.collection('events').doc(eventId).collection('chats').add({
      'senderId': currentUserId,
      'senderName': currentUserName,
      'message': text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'readBy': [currentUserId],
    });
  }


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
