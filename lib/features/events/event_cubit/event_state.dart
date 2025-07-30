import '../../../models.dart/event_model.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<EventModel> events;

  EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}

class EventJoinLoading extends EventState {}

class EventJoinSuccess extends EventState {}

class EventJoinError extends EventState {
  final String message;

  EventJoinError(this.message);
}

class EventInterestedLoaded extends EventState {
  final List<EventModel> interestedEvents;

  EventInterestedLoaded(this.interestedEvents);
}
