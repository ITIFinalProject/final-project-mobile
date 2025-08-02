import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/edit%20event/edit_event_view.dart';
import 'package:eventify_app/features/add_memory/view/add_memory.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/events/widgets/event_card.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryEventsView extends StatefulWidget {
  const CategoryEventsView({super.key});

  @override
  State<CategoryEventsView> createState() => _CategoryEventsViewState();
}

class _CategoryEventsViewState extends State<CategoryEventsView> {
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchEvents();
    context.read<EventCubit>().fetchInterestedEvents();
  }

  @override
  Widget build(BuildContext context) {
    // final String category = ModalRoute.of(context)!.settings.arguments as String;
    final args = ModalRoute.of(context)!.settings.arguments;
    final bool isAll = args is List<String>;
    final List<String> allCategories =
        isAll ? args as List<String> : [args as String];
    return Scaffold(
      appBar: AppBar(
        // title: Text(category),
        title: Text(isAll ? "All Events" : allCategories.first),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('events')
                // .where('category', isEqualTo: category)
                .where(
                  'category',
                  whereIn:
                      allCategories.length > 10
                          ? allCategories.sublist(0, 10)
                          : allCategories,
                )
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<EventModel> categoryEvents =
              snapshot.data!.docs
                  .map(
                    (doc) =>
                        EventModel.fromMap(doc.data() as Map<String, dynamic>),
                  )
                  .toList();

          if (categoryEvents.isEmpty) {
            return CardNoEvents(
              text: '"No events found in this category."',
              title: 'Events Category',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categoryEvents.length,
            itemBuilder: (context, index) {
              final event = categoryEvents[index];
                  // return GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRoutes.eventPreview, // عدلي لو اسمك مختلف
                  //       arguments: event,
                  //     );
                  //   },
                  //
                  //   child:
              return CardEvent(
                      event: event,
                      onDelete: () {
                        context.read<EventCubit>().deleteEvent(event.id);
                      },
                      onJoin: () {
                        context.read<EventCubit>().joinEvent(event);
                      },
                      // onAddMemory: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => AddMemory(event: event),
                      //     ),
                      //   );
                      // },
                    );
                  // );
                },
              );
        },
      ),
    );
  }
}
