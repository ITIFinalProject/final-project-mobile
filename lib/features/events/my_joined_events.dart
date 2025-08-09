import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../profile/cubit/theme_cubit.dart';
import 'event_cubit/event_cubit.dart';
import 'event_cubit/event_state.dart';

class MyJoinedEvents extends StatefulWidget {
  const MyJoinedEvents({super.key});

  @override
  State<MyJoinedEvents> createState() => _MyJoinedEventsState();
}

class _MyJoinedEventsState extends State<MyJoinedEvents> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchJoinedEvents();
  }

  @override
  void didPopNext() {
    context.read<EventCubit>().fetchJoinedEvents();
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

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).joinedEvents), elevation: 2),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1B3C53)),
            );
          } else if (state is EventJoinedLoaded) {
            final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

            // ✅ فلترة في الـ UI
            final filteredEvents =
                state.joinedEvents
                    .where((event) => event.hostId != userId)
                    .toList();

            if (filteredEvents.isEmpty) {
              return CardNoEvents(
                text: S.of(context).no_created_events,
                title: S.of(context).no_events_created,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text('leave Event'),
                            content: Text(
                              'Are you sure you want to leave this event?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<EventCubit>().leaveEvent(event);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  S.of(context).ok,
                                  style: TextStyle(
                                    color: ThemeManager.primaryColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  S.of(context).cancel,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CardEvent(event: event, showStar: false),
                  ),
                );
              },
            );
          } else if (state is EventError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
