import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:eventify_app/models.dart/event_model.dart';

import '../add_memory/view/add_memory.dart';
import '../home/widgets/card_event_upcoming.dart';

class InterestedEventsView extends StatefulWidget {
  const InterestedEventsView({super.key});

  @override
  State<InterestedEventsView> createState() => _InterestedEventsViewState();
}

class _InterestedEventsViewState extends State<InterestedEventsView> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchInterestedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(S.of(context).interestedEvents)),

      body: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          if (state is EventJoinSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(S.of(context).joinedSuccessfully)));
          } else if (state is EventJoinError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventInterestedLoaded) {
            if (state .interestedEvents.isEmpty) {
              return CardNoEvents(
                text: S.of(context).noInterestedEvents,
                title: S.of(context).interestedEvents,
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.interestedEvents.length,
                itemBuilder: (context, index) {
                  final event = state.interestedEvents[index];
                  return CardEventUpcoming(event: event,);
                  // return Padding(
                  //   padding: const EdgeInsets.only(bottom: 12),
                  //   child: CardEvent(
                  //     event: event,
                  //     // isInterested: true,
                  //     // onToggleInterested: () {
                  //     //   context.read<EventCubit>().toggleInterestedEvent(event);
                  //     //   // context.read<EventCubit>().fetchInterestedEvents();
                  //     //   // setState(() {});
                  //     // },
                  //     onDelete: () {
                  //       context.read<EventCubit>().deleteEvent(event.id);
                  //       // context.read<EventCubit>().fetchInterestedEvents();
                  //       // setState(() {});
                  //     },
                  //     // onEdit: () {
                  //     //   Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) {
                  //     //         return EditEventView(event: event);
                  //     //       },
                  //     //     ),
                  //     //
                  //     //   );
                  //     // },
                  //     onJoin: () {
                  //       context.read<EventCubit>().joinEvent(event);
                  //       context.read<EventCubit>().fetchInterestedEvents();
                  //     },
                  //     // onAddMemory: (){
                  //     //   Navigator.push(context,MaterialPageRoute(builder: (context)=>AddMemory(event: event)));
                  //     // },
                  //   ),
                  // );
                },
              );
            }
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
