import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_memory/view/add_memory.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventMemoryView extends StatefulWidget {
  const EventMemoryView({super.key});

  @override
  State<EventMemoryView> createState() => _EventMemoryViewState();
}

class _EventMemoryViewState extends State<EventMemoryView> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchJoinedStartedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(S.of(context).eventMemories)),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventLoaded) {
            final events = state.events;
            if (events.isEmpty) {
              return CardNoEvents(
                text: S.of(context).noEndedEventsYet,
                title: S.of(context).eventMemory,
              );
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: ThemeManager.primaryColor),
                    ),
                    title: Text(event.title),
                    subtitle: Text(event.date.toString()),
                    trailing: Icon(Icons.photo_library),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMemory(event: event),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
