import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  String name = "";
  List<EventModel> allEvents = [];
  List<EventModel> filteredEvents = [];

  void initHome({required String userName, required List<EventModel> events}) {
    name = userName;
    allEvents = events;
    emit(HomeLoaded(name: name, allEvents: events, filteredEvents: []));
  }

  void search(String query) {
    final filtered =
        allEvents
            .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
    emit(
      HomeLoaded(name: name, allEvents: allEvents, filteredEvents: filtered),
    );
  }

  Future<void> fetchNearestJoinedEvent() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('eventsJoined')
              .get();

      print("Fetched ${snapshot.docs.length} joined events");

      final events =
          snapshot.docs
              .map((doc) {
                final data = doc.data();
                print("Event data: $data");

                return {
                  'title': data['title'],
                  'date': extractStartDateTime(data),
                };
              })
              .where((e) {
                final isAfterNow = e['date']!.isAfter(DateTime.now());
                print("Event ${e['title']} is after now: $isAfterNow");
                return isAfterNow;
              })
              .toList();

      print("Filtered upcoming events count: ${events.length}");

      events.sort((a, b) => a['date']!.compareTo(b['date']!));

      if (events.isNotEmpty) {
        print("Emitting NearestEventLoaded");

        print("Emitting NearestEventLoaded");
      } else {
        print("Emitting NoUpcomingEvent");
      }
    } catch (e, stack) {
      print("Error in fetchNearestJoinedEvent: $e");
      print(stack);
    }
  }

  DateTime extractStartDateTime(Map<String, dynamic> event) {
    final dateRange = event['date']?.split(' _ ');
    final timeRange = event['time']?.split(' - ');

    if (dateRange == null || timeRange == null) return DateTime.now();

    final date = dateRange[0]; // "01/08/2025"
    final time = timeRange[0]; // "09:00 PM"

    final dateTimeStr = "$date $time";
    final format = DateFormat("yyyy-MM-dd hh:mm a");
    return format.parse(dateTimeStr);
  }
}
