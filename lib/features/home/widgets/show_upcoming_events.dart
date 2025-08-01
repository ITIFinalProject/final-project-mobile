import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/home/widgets/card_event_upcoming.dart';
import 'package:flutter/material.dart';

import '../../../core/routes.dart';
import '../../../models.dart/event_model.dart';

class ShowUpcomingEvents extends StatelessWidget {
  final List<EventModel> upcomingEvents;

  const ShowUpcomingEvents({super.key, required this.upcomingEvents});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: upcomingEvents.isEmpty?CardNoEvents(text: 'No Events Created To be UpComing',title: 'No Events Created',):ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.eventPreview,
                arguments: upcomingEvents[index],
              );
            },
            child: CardEventUpcoming(event: upcomingEvents[index]),
          );
        },
        itemCount: upcomingEvents.length,
      ),
    );
  }
}
