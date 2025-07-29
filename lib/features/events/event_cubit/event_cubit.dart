import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models.dart/event_model.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());
// **************************************************************************
  Future<void> fetchEvents() async {
    emit(EventLoading());

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('events').get();

      final events =
          snapshot.docs.map((doc) => EventModel.fromMap(doc.data())).toList();

      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError("Error occurred during Loading Events"));
    }
  }
// **************************************************************************
  Future<void> joinEvent(EventModel event) async {
    emit(EventJoinLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(EventJoinError("User not logged in"));
        return;
      }
      if (event.capacity <= 0) {
        emit(EventJoinError("Sorry, this event is full."));
        return;
      }
      final userEventRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('eventsJoined')
          .doc(event.id);

      await userEventRef.set(event.toMap());

      final eventRef = FirebaseFirestore.instance
          .collection('events')
          .doc(event.id);
      await eventRef.update({'capacity': event.capacity - 1});

      emit(EventJoinSuccess());
    } catch (e) {
      emit(EventJoinError(e.toString()));
    }
  }
// *******************************************************************************
  Future<void> fetchJoinedEvents() async {
    emit(EventLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(EventError("User not logged in"));
        return;
      }

      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('eventsJoined')
              .get();

      final events =
          snapshot.docs.map((doc) => EventModel.fromMap(doc.data())).toList();

      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError("Error fetching joined events"));
    }
  }
  // ****************************************************************************
  Future<void> fetchMyEvents() async {
    emit(EventLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(EventError("User not logged in"));
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('hostId', isEqualTo: user.uid)
          .get();

      final events =
          snapshot.docs.map((doc) => EventModel.fromMap(doc.data())).toList();

      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError("Error fetching my events"));
    }
  }
  // *************************************************************************************
  Future<void> deleteEvent(String eventId) async {
  emit(EventLoading()); 

  try {

    await FirebaseFirestore.instance.collection('events').doc(eventId).delete();
  await fetchMyEvents();


  } catch (e) {
    emit(EventError("Error deleting event: $e"));
  }
}
}
