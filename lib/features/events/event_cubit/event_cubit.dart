import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models.dart/event_model.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());
  // **************************************************************************
  Set<String> _interestedEventIds = {};

  Set<String> get interestedEventIds => _interestedEventIds;
  Future<void> fetchEvents() async {
    emit(EventLoading());

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('events').get();

      final events =
          // snapshot.docs.map((doc) => EventModel.fromMap(doc.data())).toList();
          // ***************************************************
          snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id; // نضيف id بتاع الـ document نفسه
            return EventModel.fromMap(data);
          }).toList();
      // ***********************************************************************
      emit(EventLoaded(events));
    }
    // catch (e) {
    //     emit(EventError("Error occurred during Loading Events"));
    //   }
    catch (e, stack) {
      print("🔥 Firestore Error: $e");
      print(stack);
      emit(EventError(e.toString()));
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

      final snapshot =
          await FirebaseFirestore.instance
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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(EventError("User not logged in"));
        return;
      }
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .delete();
      // ✅ Also remove from current user's interested events
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('interestedEvents')
          .doc(eventId)
          .delete();

      // ✅ Update local cache
      _interestedEventIds.remove(eventId);
      await fetchMyEvents();
      emit(EventDeleted());
    } catch (e) {
      emit(EventError("Error deleting event: $e"));
    }
  }

  // **************************************************************
  Future<void> toggleInterestedEvent(EventModel event) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('interestedEvents')
        .doc(event.id);

    final snapshot = await favRef.get();

    if (snapshot.exists) {
      await favRef.delete();
      _interestedEventIds.remove(event.id);
    } else {
      await favRef.set(event.toMap());
      _interestedEventIds.add(event.id);
    }

    // ✅ إعادة إرسال نفس الـ state عشان يحصل rebuild مباشر
    if (state is EventLoaded) {
      emit(EventLoaded((state as EventLoaded).events));
    } else if (state is EventInterestedLoaded) {
      emit(
        EventInterestedLoaded(
          (state as EventInterestedLoaded).interestedEvents,
        ),
      );
    }
  }

  // *******************************************************
  Future<void> fetchInterestedEvents() async {
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
              .collection('interestedEvents')
              .get();
      _interestedEventIds = snapshot.docs.map((doc) => doc.id).toSet();

      final events =
          snapshot.docs.map((doc) => EventModel.fromMap(doc.data())).toList();

      emit(EventInterestedLoaded(events));
    } catch (e) {
      emit(EventError("Error fetching interested events"));
    }
  }

  bool isInterested(String eventId) {
    return _interestedEventIds.contains(eventId);
  }


//   Future<void> fetchJoinedEndedEvents() async {
//   emit(EventLoading());
//
//   try {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       emit(EventError("User not logged in"));
//       return;
//     }
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .collection('eventsJoined')
//         .get();
//
//     final now = DateTime.now();
//
//     final events = snapshot.docs
//         .map((doc) => EventModel.fromMap(doc.data()))
//         .where((event) => event.eventEndDateTime.isBefore(now)) // ✅ الأحداث المنتهية فقط
//         .toList();
//
//     emit(EventLoaded(events));
//   } catch (e) {
//     emit(EventError("Error fetching ended joined events"));
//   }
// }


//   ==============================
  Future<void> fetchJoinedStartedEvents() async {
    emit(EventLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(EventError("User not logged in"));
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('eventsJoined')
          .get();

      final now = DateTime.now();

      final events = snapshot.docs
          .map((doc) => EventModel.fromMap(doc.data()))
          .where((event) => isEventStartedOrPast(event.date))
          .toList();

      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError("Error fetching started joined events"));
    }
  }
  bool isEventStartedOrPast(String dateString) {
    try {
      String date;
      if (dateString.contains('_')) {
        date = dateString.split(' _').first.trim();
      } else {
        date = dateString;
      }
      final startDate = DateFormat('dd-MM-yyyy').parse(date);
      final today = DateTime.now();

      return today.isAfter(startDate) || isSameDay(today, startDate);
    } catch (_) {
      return false;
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

// *************************************************************
