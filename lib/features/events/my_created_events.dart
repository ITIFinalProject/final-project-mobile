import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:eventify_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/generated/l10n.dart';

import '../../core/routes.dart';
import '../add_memory/view/add_memory.dart';
import '../profile/cubit/theme_cubit.dart';

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
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).my_events,
        ),
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
              return CardNoEvents(
                text: '"You haven’t created any events yet."',
                title: 'No Events Created',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CardEvent(
                    event: event,
                    onDelete: () async {
                      showDialogDelete(event.id);
                    },
                    onJoin: () {
                      context.read<EventCubit>().joinEvent(event);
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
  showDialogDelete(String eventId) {
    showDialog(context: context, builder: (context) {
      return  BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if(state is EventDeleted){
            context.read<EventCubit>().fetchMyEvents();
            Navigator.pop(context);
          }else{
            return AlertDialog(
              content: Text('Are you sure you want to delete this event' , style: TextStyle(
                  fontSize: 16,
                color: ThemeManager.secondaryColor
              ),),
              title: Text('Delete Event',style: TextStyle(color: ThemeManager.primaryColor),),
              actions: [
                TextButton(onPressed: (){
                  context.read<EventCubit>().deleteEvent(eventId);
                }, child: Text('Ok',style: TextStyle(color: ThemeManager.primaryColor),)),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel', style: TextStyle(color: Colors.grey),)),
              ],
            );
          }
          return SizedBox.shrink();
        });
    }
      );
    }

  }
