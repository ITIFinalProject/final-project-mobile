import 'package:cloud_firestore/cloud_firestore.dart';

class EventChatMessage {
  final String senderId;
  final String senderName;
  final String message;
  final Timestamp createdAt;
  final List<String> readBy;

  EventChatMessage({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.createdAt,
    required this.readBy
  });

  factory EventChatMessage.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventChatMessage(
      senderId: data['senderId'],
      senderName: data['senderName'],
      message: data['message'],
      createdAt: data['createdAt'],
      readBy: List<String>.from(data['readBy'] ?? []),
    );
  }
}
