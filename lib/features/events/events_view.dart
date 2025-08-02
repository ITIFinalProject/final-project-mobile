// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
// import 'package:eventify_app/features/events/widgets/card_no_events.dart';
// import 'package:eventify_app/features/events/widgets/event_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../../core/routes.dart';
// import '../../main.dart';
// import '../add_memory/view/add_memory.dart';
// import 'event_cubit/event_cubit.dart';
// import 'event_cubit/event_state.dart';
//
// class EventsView extends StatefulWidget {
//   const EventsView({super.key});
//
//   @override
//   State<EventsView> createState() => _EventsViewState();
// }
//
// class _EventsViewState extends State<EventsView> with RouteAware {
//   DateTime? selectedDate = DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<EventCubit>().fetchEvents();
//     context.read<EventCubit>().fetchInterestedEvents();
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: AppBar(
//           title: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Text('Events'),
//           ),
//         ),
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFF456882).withOpacity(0.2),
//                       blurRadius: 6,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: TableCalendar(
//                   firstDay: DateTime.utc(2020, 1, 1),
//                   lastDay: DateTime.utc(2030, 12, 31),
//                   focusedDay: DateTime.now(),
//                   headerStyle: const HeaderStyle(
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                     leftChevronIcon: Icon(Icons.chevron_left),
//                     rightChevronIcon: Icon(Icons.chevron_right),
//                   ),
//                   calendarStyle: const CalendarStyle(
//                     todayDecoration: BoxDecoration(
//                       color: ThemeManager.darkPinkColor,
//                       shape: BoxShape.circle,
//                     ),
//                     selectedDecoration: BoxDecoration(
//                       color: Color(0xFF1B3C53),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   daysOfWeekStyle: const DaysOfWeekStyle(
//                     weekendStyle: TextStyle(color: Colors.black54),
//                     weekdayStyle: TextStyle(color: Colors.black87),
//                   ),
//                   availableGestures: AvailableGestures.all,
//                   onDaySelected: (selectedDay, focusedDay) {
//                     setState(() {
//                       selectedDate = selectedDay;
//                     });
//                   },
//                   selectedDayPredicate: (day) {
//                     return isSameDay(selectedDate, day);
//                   },
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//               BlocBuilder<EventCubit, EventState>(
//                 builder: (context, state) {
//                   if (state is EventLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: ThemeManager.primaryColor,
//                       ),
//                     );
//                   } else if (state is EventLoaded) {
//                     final filteredEvents =
//                         selectedDate == null
//                             ? state.events
//                             : state.events.where((event) {
//                               try {
//                                 final parts = event.date.contains('_');
//                                 if (parts) {
//                                   final datePart = event.date.split('_');
//                                   final eventDate = DateFormat(
//                                     'yyyy-MM-dd',
//                                   ).parse(datePart.first.trim());
//                                   return eventDate.year == selectedDate!.year &&
//                                       eventDate.month == selectedDate!.month &&
//                                       eventDate.day == selectedDate!.day;
//                                 } else {
//                                   final datePart = event.date;
//                                   final eventDate = DateFormat(
//                                     'yyyy-MM-dd',
//                                   ).parse(datePart);
//                                   return eventDate.year == selectedDate!.year &&
//                                       eventDate.month == selectedDate!.month &&
//                                       eventDate.day == selectedDate!.day;
//                                 }
//                               } catch (e) {
//                                 return false;
//                               }
//                             }).toList();
//                     if (filteredEvents.isEmpty) {
//                       return CardNoEvents(
//                         text: 'Create an event and make some memorizes',
//                         title: 'No Events in that Day',
//                       );
//                     }
//                     return Column(
//                       children:
//                           filteredEvents.map((event) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 12),
//                               child: CardEvent(
//                                 event: event,
//                                 onDelete: () {
//                                  showDialogDelete(event.id);
//                                 },
//                                 onJoin: () async{
//                                   await context.read<EventCubit>().joinEvent(event);
//                                   await context.read<EventCubit>().fetchEvents();
//                                 },
//                               ),
//                             );
//                           }).toList(),
//                     );
//                   }else if (state is EventJoinSuccess) {
//                     context.read<EventCubit>().fetchEvents();
//                     return Center(child: CircularProgressIndicator()); // مؤقت
//                   } else if (state is EventError) {
//                     return Center(child: Text(state.message));
//                   }
//
//                   return const SizedBox.shrink();
//                 },
//               ),
//
//               const SizedBox(height: 70),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void didPopNext() {
//     context.read<EventCubit>().fetchEvents();
//     context.read<EventCubit>().fetchInterestedEvents();
//     context.read<EventCubit>().fetchMyEvents();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)!);
//   }
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       context.read<EventCubit>().fetchEvents();
//     }
//   }
//   showDialogDelete(String eventId) {
//     showDialog(context: context, builder: (context) =>
//         BlocBuilder<EventCubit, EventState>(
//           builder: (context, state) {
//             if(state is EventDeleted){
//               context.read<EventCubit>().fetchMyEvents();
//               Navigator.pop(context);
//             }else{
//               return AlertDialog(
//                 content: Text('Are you sure you want to delete this event'),
//                 title: Text('Delete Event'),
//                 actions: [
//                   TextButton(onPressed: (){
//                     context.read<EventCubit>().deleteEvent(eventId);
//                   }, child: Text('Ok')),
//                   TextButton(onPressed: (){
//                     Navigator.pop(context);
//                   }, child: Text('Cancel')),
//                 ],
//               );
//             }
//             return SizedBox.shrink();
//           },
//         ));
//   }
//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   // showNoEvents() {
//   //   return Card(
//   //     color: ThemeManager.lightPinkColor,
//   //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.circular(15),
//   //       side: BorderSide(color: ThemeManager.secondaryColor),
//   //     ),
//   //     child: Padding(
//   //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//   //       child: Row(
//   //         children: [
//   //           CircleAvatar(
//   //             radius: 28,
//   //             backgroundColor: Color(0xFFF9F3EF),
//   //             child: const Icon(
//   //               Icons.calendar_today,
//   //               color: Color(0xFF1B3C53),
//   //               size: 30,
//   //             ),
//   //           ),
//   //           const SizedBox(width: 50),
//   //           const Expanded(
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Text(
//   //                   'No Events',
//   //                   style: TextStyle(
//   //                     fontWeight: FontWeight.bold,
//   //                     color: Color(0xFF1B3C53),
//   //                   ),
//   //                 ),
//   //                 SizedBox(height: 8),
//   //                 Text(
//   //                   "Create an event and make some memories.",
//   //                   style: TextStyle(fontSize: 13, color: Color(0xFF456882)),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart'; // Corrected import syntax for spaces
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:eventify_app/generated/l10n.dart';

import '../../core/routes.dart';
import '../../main.dart'; // Assuming routeObserver is defined in main.dart
import '../add_memory/view/add_memory.dart';
import 'event_cubit/event_cubit.dart';
import 'event_cubit/event_state.dart';
import '../../models.dart/event_model.dart'; // Make sure EventModel is imported


class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> with RouteAware, WidgetsBindingObserver {
  DateTime? selectedDate = DateTime.now();
  List<EventModel> allEvents = []; // To store all fetched events
  List<EventModel> interestedEvents = []; // To store interested events

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer for app lifecycle
    // Fetch events immediately when the widget is initialized
    _fetchData();
  }

  void _fetchData() {
    context.read<EventCubit>().fetchEvents(); // Fetch all public events
    context.read<EventCubit>().fetchInterestedEvents(); // Fetch events the user is interested in
    // Note: fetchMyEvents() might be for a different tab/view, so keeping it out unless needed here.
  }

  @override
  void didPopNext() {
    // Called when the current route has been popped off, and this route is in view again.
    // This is crucial for refreshing data when returning from another page.
    _fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route events after the widget is fully initialized
    // to ensure ModalRoute.of(context) is not null.
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
    if (currentRoute != null) {
      routeObserver.subscribe(this, currentRoute);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Fetch data when the app resumes from the background
    if (state == AppLifecycleState.resumed) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(S.of(context).events,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: ThemeManager.primaryColor, // Ensure AppBar color is set
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF456882).withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: selectedDate ?? DateTime.now(), // Use selectedDate for focusedDay
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(Icons.chevron_left),
                    rightChevronIcon: Icon(Icons.chevron_right),
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: ThemeManager.darkPinkColor,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF1B3C53),
                      shape: BoxShape.circle,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.black54),
                    weekdayStyle: TextStyle(color: Colors.black87),
                  ),
                  availableGestures: AvailableGestures.all,
                  onDaySelected: (newSelectedDay, newFocusedDay) {
                    setState(() {
                      selectedDate = newSelectedDay;
                      // Update focusedDay to the newly selected day to keep calendar centered
                      // focusedDay = newFocusedDay; // Not needed if focusedDay uses selectedDate
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<EventCubit, EventState>(
                listener: (context, state) {
                  if (state is EventJoinSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Joined Successfully")),
                    );
                    // Crucially, refetch all events to update the list
                    _fetchData(); // Trigger full refresh
                  } else if (state is EventJoinError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is EventError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: ${state.message}")),
                    );
                  } else if (state is EventDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Event Deleted Successfully")),
                    );
                    _fetchData(); // Refresh data after deletion
                    Navigator.pop(context); // Pop the delete dialog if it was showing
                  }
                  // We update the local lists here
                  if (state is EventLoaded) {
                    allEvents = state.events;
                  } else if (state is EventInterestedLoaded) {
                    interestedEvents = state.interestedEvents;
                  }
                },
                builder: (context, state) {
                  // Display loading indicator if any relevant loading state
                  if (state is EventLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ThemeManager.primaryColor,
                      ),
                    );
                  }
                  final List<EventModel> currentEventsToDisplay;

                  // Determine which events to display based on the last loaded state
                  if (state is EventLoaded) {
                    currentEventsToDisplay = state.events;
                  } else if (state is EventInterestedLoaded) {
                    currentEventsToDisplay = allEvents;
                  } else {
                    currentEventsToDisplay = allEvents;
                  }


                  // --- Start UI Filtering Logic ---
                  final List<EventModel> filteredEventsByAccess = currentEventsToDisplay.where((event) {
                    // Rule 1: Always include public events
                    if (event.type.toLowerCase() == 'public') {
                      return true;
                    }

                    // Rule 2: If a user is logged in, include events they host
                    if (currentUser != null && event.hostId == currentUser.uid) {
                      return true;
                    }

                    // Rule 3: If a user is logged in, include private events they are invited to
                    if (currentUser != null &&
                        event.type.toLowerCase() == 'private' &&
                        event.guests != null) {
                      return event.guests!.any((guest) => guest.uid == currentUser.uid);
                    }

                    // Exclude all other events (e.g., private events not hosted by or for the user)
                    return false;
                  }).toList();
                  // --- End UI Filtering Logic ---


                  // Now apply date filtering to the already access-filtered events
                  final List<EventModel> finalFilteredEvents = filteredEventsByAccess.where((event) {
                    if (selectedDate == null) return true; // Show all if no date selected

                    try {
                      // Normalize event date to remove time parts for comparison
                      String eventDateString = event.date.contains('_')
                          ? event.date.split('_').first.trim()
                          : event.date.trim();

                      // Robust date parsing for "yyyy-MM-dd"
                      final DateTime eventDate = DateFormat('yyyy-MM-dd').parse(eventDateString);

                      // Compare only year, month, and day
                      return eventDate.year == selectedDate!.year &&
                          eventDate.month == selectedDate!.month &&
                          eventDate.day == selectedDate!.day;
                    } catch (e) {
                      print("Error parsing event date for filtering: ${event.date} -> $e");
                      return false; // Exclude events with unparsable dates
                    }
                  }).toList();

                  if (finalFilteredEvents.isEmpty) {
                    return CardNoEvents(
                      text: 'Create an event and make some memories',
                      title: 'No Events for that Day',
                    );
                  }

                  // Sort events by date and time to ensure consistent order
                  finalFilteredEvents.sort((a, b) {
                    DateTime? dateTimeA;
                    DateTime? dateTimeB;
                    try {
                      dateTimeA = DateFormat("yyyy-MM-dd HH:mm").parse("${a.date.split('_').first.trim()}${a.time.split('-').first.trim()}");
                      dateTimeB = DateFormat("yyyy-MM-dd HH:mm").parse("${b.date.split('_').first.trim()}${b.time.split('-').first.trim()}");
                    } catch (e) {
                      // Fallback to date only if time parsing fails
                      try {
                        dateTimeA = DateFormat("yyyy-MM-dd").parse(a.date.split('_').first.trim());
                        dateTimeB = DateFormat("yyyy-MM-dd").parse(b.date.split('_').first.trim());
                      } catch (e) {
                        // If all parsing fails, maintain original order
                      }
                    }
                    if (dateTimeA != null && dateTimeB != null) {
                      return dateTimeA.compareTo(dateTimeB);
                    }
                    return 0; // Keep original order if dates can't be parsed
                  });


                  return Column(
                    children: finalFilteredEvents.map((event) {

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CardEvent(
                          event: event,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogDelete(String eventId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value( // Use BlocProvider.value to provide the existing cubit
          value: context.read<EventCubit>(),
          child: BlocConsumer<EventCubit, EventState>(
            listener: (innerContext, state) {
              // This listener handles state changes specific to the delete dialog
              if (state is EventDeleted) {
                // Event deletion successful, dismiss dialog and refresh main list
                Navigator.of(innerContext).pop(); // Dismiss the dialog
                // The main listener in the EventsView will then call _fetchData()
              } else if (state is EventError) {
                ScaffoldMessenger.of(innerContext).showSnackBar(
                  SnackBar(content: Text("Deletion Error: ${state.message}")),
                );
                Navigator.of(innerContext).pop(); // Dismiss dialog on error as well
              }
            },
            builder: (innerContext, state) {
              if (state is EventLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return AlertDialog(
                content: const Text('Are you sure you want to delete this event?'),
                title: const Text('Delete Event'),
                actions: [
                  TextButton(
                    onPressed: () {
                      innerContext.read<EventCubit>().deleteEvent(eventId);
                    },
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(innerContext).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }


  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }
}