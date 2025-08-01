import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/routes.dart';
import '../../main.dart';
import '../add_memory/view/add_memory.dart';
import 'event_cubit/event_cubit.dart';
import 'event_cubit/event_state.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> with RouteAware {
  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchEvents();
    context.read<EventCubit>().fetchInterestedEvents();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('Events'),
          ),
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
                      color: Color(0xFF456882).withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
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
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                ),
              ),

              const SizedBox(height: 20),
              BlocBuilder<EventCubit, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ThemeManager.primaryColor,
                      ),
                    );
                  } else if (state is EventLoaded) {
                    final filteredEvents =
                        selectedDate == null
                            ? state.events
                            : state.events.where((event) {
                              try {
                                final parts = event.date.contains('_');
                                if (parts) {
                                  final datePart = event.date.split('_');
                                  final eventDate = DateFormat(
                                    'dd-MM-yyyy',
                                  ).parse(datePart.first.trim());
                                  return eventDate.year == selectedDate!.year &&
                                      eventDate.month == selectedDate!.month &&
                                      eventDate.day == selectedDate!.day;
                                } else {
                                  final datePart = event.date;
                                  final eventDate = DateFormat(
                                    'dd-MM-yyyy',
                                  ).parse(datePart);
                                  return eventDate.year == selectedDate!.year &&
                                      eventDate.month == selectedDate!.month &&
                                      eventDate.day == selectedDate!.day;
                                }
                              } catch (e) {
                                return false;
                              }
                            }).toList();
                    if (filteredEvents.isEmpty) {
                      return CardNoEvents(
                        text: 'Create an event and make some memorizes',
                        title: 'No Events in that Day',
                      );
                    }
                    return Column(
                      children:
                          filteredEvents.map((event) {
                            final isInterested = context
                                .read<EventCubit>()
                                .isInterested(event.id);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CardEvent(
                                onToggleInterested: () {
                                  context
                                      .read<EventCubit>()
                                      .toggleInterestedEvent(event);
                                  setState(() {}); //
                                },
                                isInterested: isInterested,
                                event: event,
                                onDelete: () {
                                  context.read<EventCubit>().deleteEvent(
                                    event.id,
                                  );
                                },
                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditEventView(event: event);
                                      },
                                    ),
                                  );
                                },
                                onJoin: () {
                                  context.read<EventCubit>().joinEvent(event);
                                },
                                onAddMemory: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>AddMemory(event: event)));
                                },
                              ),
                            );
                          }).toList(),
                    );
                  } else if (state is EventError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didPopNext() {
    context.read<EventCubit>().fetchEvents();
    context.read<EventCubit>().fetchInterestedEvents();
    context.read<EventCubit>().fetchMyEvents();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // showNoEvents() {
  //   return Card(
  //     color: ThemeManager.lightPinkColor,
  //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //       side: BorderSide(color: ThemeManager.secondaryColor),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //       child: Row(
  //         children: [
  //           CircleAvatar(
  //             radius: 28,
  //             backgroundColor: Color(0xFFF9F3EF),
  //             child: const Icon(
  //               Icons.calendar_today,
  //               color: Color(0xFF1B3C53),
  //               size: 30,
  //             ),
  //           ),
  //           const SizedBox(width: 50),
  //           const Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'No Events',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xFF1B3C53),
  //                   ),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   "Create an event and make some memories.",
  //                   style: TextStyle(fontSize: 13, color: Color(0xFF456882)),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
