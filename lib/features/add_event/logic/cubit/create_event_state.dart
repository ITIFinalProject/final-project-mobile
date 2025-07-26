part of 'create_event_cubit.dart';


@immutable
abstract class CreateEventState {}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {
  final EventModel event;

  CreateEventSuccess(this.event);
}

class CreateEventError extends CreateEventState {
  final String message;

  CreateEventError(this.message);
}
