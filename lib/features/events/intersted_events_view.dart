import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:eventify_app/models.dart/event_model.dart';

class InterestedEventsView extends StatefulWidget {
  const InterestedEventsView({super.key});

  @override
  State<InterestedEventsView> createState() => _InterestedEventsViewState();
}

class _InterestedEventsViewState extends State<InterestedEventsView> {
  @override
  void initState() {
    super.initState();
    // نجيب الأحداث المهتم بها
    context.read<EventCubit>().fetchInterestedEvents();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interested Events")),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventInterestedLoaded) {
            if (state.interestedEvents.isEmpty) {
              return const Center(child: Text("No interested events yet."));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.interestedEvents.length,
              itemBuilder: (context, index) {
                final event = state.interestedEvents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CardEvent(
                    event: event,
                    isInterested: true,
                    onToggleInterested: () {
                      context.read<EventCubit>().toggleInterestedEvent(event);
                      context.read<EventCubit>().fetchInterestedEvents();
                      setState(() {});
                    },
                    onDelete: () {
                      context.read<EventCubit>().deleteEvent(event.id);
                      (state is EventDeleted)
                          ? CircularProgressIndicator()
                          : context.read<EventCubit>().fetchInterestedEvents();
                      // setState(() {});
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
