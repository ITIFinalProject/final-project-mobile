import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/messages/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/generated/l10n.dart';
import '../events/event_cubit/event_state.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchJoinedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).messages),
        automaticallyImplyLeading: false,
      ),

      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EventLoaded) {
            final events = state.events;
            if (events.isEmpty) {
              return Center(child: Text(S.of(context).no_joined_events_yet));
            } else {
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    color: ThemeManager.lightPinkColor,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: ThemeManager.primaryColor),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: ThemeManager.primaryColor,
                        child: Icon(Icons.group, color: Colors.white),
                      ),
                      title: Text(
                        event.title ?? '',
                        style: TextStyle(color: ThemeManager.primaryColor),
                      ),
                      subtitle: Text(S.of(context).send_a_message_to_your_guests),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatPage(eventId: event.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
