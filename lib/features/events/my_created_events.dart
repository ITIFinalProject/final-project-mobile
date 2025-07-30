import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:eventify_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCreatedEvents extends StatefulWidget {
  const MyCreatedEvents({super.key});

  @override
  State<MyCreatedEvents> createState() => _MyCreatedEventsState();
}

class _MyCreatedEventsState extends State<MyCreatedEvents> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchMyEvents();
    context.read<EventCubit>().fetchInterestedEvents();
  }

  @override
  void didPopNext() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "My Events",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: ThemeManager.primaryColor,
        elevation: 2,
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1B3C53)),
            );
          } else if (state is EventLoaded) {
            if (state.events.isEmpty) {
              return _buildNoEventsCard();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                final isInterested = context.read<EventCubit>().isInterested(event.id);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CardEvent(
                    isInterested:isInterested ,
                    onToggleInterested: () {
                      context.read<EventCubit>().toggleInterestedEvent(event);
                    },
                    event: event,
                    onDelete: () {
                      context.read<EventCubit>().deleteEvent(event.id);
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
                  ), //  نفس الكارد اللي بتستخدميه في EventsView
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

  // UI في حالة مفيش أي إيفنتات أنشأها المستخدم
  Widget _buildNoEventsCard() {
    return Center(
      child: Card(
        color: ThemeManager.lightPinkColor,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: ThemeManager.secondaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.event_busy, size: 50, color: Color(0xFF1B3C53)),
              SizedBox(height: 12),
              Text(
                'No Events Created',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1B3C53),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "You haven’t created any events yet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF456882)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
