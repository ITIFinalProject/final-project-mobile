import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_memory/view/add_memory.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:eventify_app/features/events/widgets/card_no_events.dart';
import 'package:eventify_app/features/events/widgets/disable_button.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models.dart/event_model.dart';
import '../add_event/edit event/edit_event_view.dart';
import '../auth/cubit/auth_state.dart';
import 'event_cubit/event_cubit.dart';
import 'event_cubit/event_state.dart';

class EventPreviewPage extends StatelessWidget {
  const EventPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final thememode = context.watch<ThemeCubit>().state;
    final isDarkMode = thememode == ThemeMode.dark;
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! EventModel) {
      return const Scaffold(
        body: CardNoEvents(text: "No event data provided.", title: "No data"),
      );
    }
    var event = args;
    var size = MediaQuery.of(context).size;
    String? imageUrl = event.bannerUrl;
    var date;
    if (event.date.contains('_')) {
      date = event.date.split('_').first.trim();
    } else {
      date = event.date.trim();
    }
    DateTime? eventDateTime;
    try {
      final timePart = event.time.split('-').first.trim(); // "01:03 AM"
      final formattedString = "$date $timePart"; // "2025-08-04 01:03 AM"
      eventDateTime = DateTime.parse(formattedString);
      print("Parsed event time: $eventDateTime");
    } catch (e) {
      print("Error parsing event time: $e");
    }
    print(DateTime.now());
    bool isPast =
        eventDateTime != null && DateTime.now().isAfter(eventDateTime);
    print(isPast);
    bool isUpcoming =
        eventDateTime != null && DateTime.now().isBefore(eventDateTime!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        context.read<EventCubit>().fetchJoinedEvents();
      }
    });
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is AuthSuccess) {
          context.read<EventCubit>().fetchJoinedEvents();
          // context.read<EventCubit>().fetchEvents();
        }
      },

      child: Scaffold(
        backgroundColor:
            isDarkMode
                ? ThemeManager.primaryColor
                : ThemeManager.lightPinkColor,
        appBar: AppBar(
          backgroundColor:
              isDarkMode
                  ? ThemeManager.lightPinkColor.withOpacity(0.9)
                  : ThemeManager.primaryColor.withOpacity(0.9),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child:
                    imageUrl != null && imageUrl.isNotEmpty
                        ? Image.network(
                          imageUrl,
                          width: size.width,
                          height: size.height * 0.4,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color:
                                    isDarkMode
                                        ? ThemeManager.lightPinkColor
                                        : ThemeManager.primaryColor,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        )
                        : Image.asset(
                          'assets/images/template${event.templateIndex}.jpg',
                          width: size.width,
                          height: size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      isDarkMode
                          ? ThemeManager.secondaryColor.withOpacity(0.5)
                          : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  isDarkMode
                                      ? ThemeManager.lightPinkColor
                                      : ThemeManager.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _InfoBox(icon: Icons.date_range, label: event.date),
                      const SizedBox(height: 16),
                      _InfoBox(icon: Icons.access_time, label: event.time),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color:
                                isDarkMode
                                    ? ThemeManager.lightPinkColor
                                    : ThemeManager.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    isDarkMode
                                        ? ThemeManager.lightPinkColor
                                        : ThemeManager.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (event.location.isNotEmpty)
                        TextButton.icon(
                          onPressed: () {
                            final query = Uri.encodeComponent(event.location);
                            final googleMapsUrl =
                                'https://www.google.com/maps/search/?api=1&query=$query'; // Corrected Google Maps URL
                            launchUrl(Uri.parse(googleMapsUrl));
                          },
                          icon: Icon(
                            Icons.map,
                            color:
                                isDarkMode
                                    ? ThemeManager.darkPinkColor
                                    : ThemeManager.secondaryColor,
                          ),
                          label: Text(
                            "Open in Maps",
                            style: TextStyle(
                              color:
                                  isDarkMode
                                      ? ThemeManager.darkPinkColor
                                      : ThemeManager.secondaryColor,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      Text(
                        "Hosted by:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode
                                  ? ThemeManager.lightPinkColor
                                  : ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.hostName,
                        style: TextStyle(
                          color:
                              isDarkMode
                                  ? ThemeManager.lightPinkColor
                                  : ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Event Description:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode
                                  ? ThemeManager.lightPinkColor
                                  : ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              isDarkMode
                                  ? ThemeManager.lightPinkColor
                                  : ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (event.type.toLowerCase() == "private" &&
                          event.guests!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Guest List:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...event.guests!.map(
                              (guest) => ListTile(
                                leading: Icon(
                                  Icons.person_outline,
                                  color:
                                      isDarkMode
                                          ? ThemeManager.lightPinkColor
                                          : ThemeManager.primaryColor,
                                ),
                                title: Text(
                                  guest.name!,
                                  style: TextStyle(
                                    color:
                                        isDarkMode
                                            ? ThemeManager.lightPinkColor
                                            : ThemeManager.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                          if (authState is AuthSuccess) {
                            final currentUser = authState.user;
                            if (event.hostId == currentUser.uid) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    EditEventView(event: event),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color:
                                            isDarkMode
                                                ? ThemeManager.primaryColor
                                                : ThemeManager.lightPinkColor,
                                      ),
                                      label: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color:
                                              isDarkMode
                                                  ? ThemeManager.primaryColor
                                                  : ThemeManager.lightPinkColor,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            isDarkMode
                                                ? ThemeManager.lightPinkColor
                                                : ThemeManager.primaryColor,
                                        foregroundColor:
                                            ThemeManager.lightPinkColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => BlocBuilder<
                                                EventCubit,
                                                EventState
                                              >(
                                                builder: (context, state) {
                                                  if (state is EventDeleted) {
                                                    context
                                                        .read<EventCubit>()
                                                        .fetchEvents();
                                                  } else {
                                                    return AlertDialog(
                                                      content: Text(
                                                        'Are you sure you want to delete this event',
                                                        style: TextStyle(
                                                          color:
                                                              ThemeManager
                                                                  .secondaryColor,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        'Delete Event',
                                                        style: TextStyle(
                                                          color:
                                                              ThemeManager
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                  EventCubit
                                                                >()
                                                                .deleteEvent(
                                                                  event.id,
                                                                );
                                                            Navigator.pushReplacementNamed(
                                                              context,
                                                              AppRoutes.layout,
                                                            );
                                                          },
                                                          child: Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                              color:
                                                                  ThemeManager
                                                                      .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                  return SizedBox.shrink();
                                                },
                                              ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      label: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[100],
                                        foregroundColor:
                                            ThemeManager.lightPinkColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return BlocConsumer<EventCubit, EventState>(
                                listener: (context, eventState) {
                                  if (eventState is EventJoinSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Joined Successfully"),
                                      ),
                                    );
                                  } else if (eventState is EventJoinError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(eventState.message),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (eventState is EventError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Error: ${eventState.message}",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, eventState) {
                                  if (eventState is EventLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: ThemeManager.primaryColor,
                                      ),
                                    );
                                  } else if (eventState is EventJoinedLoaded) {
                                    final joinedEvents =
                                        eventState.joinedEvents;
                                    final hasJoined = joinedEvents.any(
                                      (e) => e.id == event.id,
                                    );

                                    if (hasJoined && isUpcoming) {
                                      return DisableButton(
                                        label: "Already Joined",
                                      );
                                    } else if (hasJoined && isPast) {
                                      return _activeButton(
                                        "Add Memory",
                                        Icons.add_photo_alternate,
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      AddMemory(event: event),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (!hasJoined && isPast) {
                                      return DisableButton(
                                        label: "Event is Finished",
                                      );
                                    } else {
                                      // If user hasn't joined and event is upcoming or past but not joined
                                      return _activeButton(
                                        "Join Event",
                                        Icons.event_available,
                                        () {
                                          context.read<EventCubit>().joinEvent(
                                            event,
                                          );
                                          context
                                              .read<EventCubit>()
                                              .fetchJoinedEvents();
                                        },
                                      );
                                    }
                                  } else {
                                    return _activeButton(
                                      "Join Event",
                                      Icons.event_available,
                                      () {
                                        context.read<EventCubit>().joinEvent(
                                          event,
                                        );
                                        context
                                            .read<EventCubit>()
                                            .fetchJoinedEvents();
                                      },
                                    );
                                  }
                                },
                              );
                            }
                          } else {
                            // If AuthState is not AuthSuccess (e.g., AuthInitial, AuthLoading, AuthError)
                            return const SizedBox.shrink(); // Or a login prompt
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _InfoBox({required IconData icon, required String label}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xfff9f3ef),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: ThemeManager.primaryColor),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              color: ThemeManager.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _activeButton(String label, IconData icon, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeManager.secondaryColor,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
