import '../models/event_chat_messsage.dart';

abstract class EventChatState {}

class EventChatInitial extends EventChatState {}

class EventChatLoading extends EventChatState {}

class EventChatLoaded extends EventChatState {
  final List<EventChatMessage> messages;

  EventChatLoaded(this.messages);
}

class EventChatError extends EventChatState {
  final String error;

  EventChatError(this.error);
}
