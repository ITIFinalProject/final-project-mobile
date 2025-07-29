import '../../../models.dart/event_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final String name;
  final List<EventModel> allEvents;
  final List<EventModel> filteredEvents;

  HomeLoaded({
    required this.name,
    required this.allEvents,
    required this.filteredEvents,
  });
}
