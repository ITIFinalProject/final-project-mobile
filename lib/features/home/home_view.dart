import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/features/home/widgets/event_categories.dart';
import 'package:eventify_app/features/home/widgets/search_input_field.dart';
import 'package:eventify_app/features/home/widgets/show_upcoming_events.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import '../floating_button/chatscreen.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'package:eventify_app/generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String name = "";
  List<EventModel> allEvents = [];
  String searchText = '';
  List<EventModel> filterdEvents = [];
  late String userId;

  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      name = authState.user.name ?? '';
    }

      context.read<EventCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(
              listener: (context, authState) {
                final eventState = context.read<EventCubit>().state;
                if (authState is AuthSuccess && eventState is EventLoaded) {
                  context.read<HomeCubit>().initHome(
                    userName: authState.user.name ?? '',
                    events: eventState.events,
                  );
                }
              },
            ),
            BlocListener<EventCubit, EventState>(
              listener: (context, eventState) {
                final authState = context.read<AuthCubit>().state;
                if (authState is AuthSuccess && eventState is EventLoaded) {
                  context.read<HomeCubit>().initHome(
                    userName: authState.user.name ?? '',
                    events: eventState.events,
                  );
                }else if (eventState is EventError) {
      print("⚠️ حدث خطأ في تحميل الأحداث: ${eventState.message}");
    }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is! HomeLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                final name = state.name;
                allEvents = state.allEvents;
                filterdEvents = state.filteredEvents;
                userId = FirebaseAuth.instance.currentUser!.uid;
                final recommendedEvents = getRecommendedEvents(userId);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name.isNotEmpty ? "Hello, $name! 👋" :  S.of(context).welcome,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ThemeManager.primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                              
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.interestedEventsView,
                                );
                              }, icon: Icon(Icons.star_outline_rounded,size: 30,)),
                              IconButton(onPressed: (){
                              
                              }, icon: Icon(Icons.notifications_active,size: 30,)),
                            ],
                          )

                        ],
                      ),
                      const SizedBox(height: 20),
                      SearchInputField(
                        onChange: (value) {
                          searchText = value;
                          context.read<HomeCubit>().search(value);
                            }

                      ),
                      if (searchText.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          'Search Results',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ThemeManager.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        filterdEvents.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filterdEvents.length,
                          itemBuilder: (context, index) {
                            final event = filterdEvents[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, AppRoutes.eventPreview,arguments: event);
                              },
                              child: ListTile(
                                title: Text(event.title),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.eventPreview,
                                    arguments: event,
                                  );
                                },
                              ),
                            );
                          },
                        )
                            : const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("No results found."),
                        ),
                      ],
                      const SizedBox(height: 20),
                      const EventCategories(),
                      const SizedBox(height: 20),
                      Text(
                        S.of(context).upcoming_events,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ShowUpcomingEvents(upcomingEvents: getUpcomingEvents()),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).recommended_events,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ShowUpcomingEvents(upcomingEvents: recommendedEvents),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            ),
        backgroundColor: const Color(0xFF1B3C53),
        child: SvgPicture.asset(
          'assets/images/ChatGPT-Logo.svg',
          width: 32,
          height: 32,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  // List<EventModel> getUpcomingEvents() {
  //   final now = DateTime.now();
  //   final upcoming =
  //       allEvents.where((event) {
  //           try {
  //             final parts = event.date.split(' _').first.trim().split('-');
  //             final parsedDate = DateTime(
  //               int.parse(parts[0]),
  //               int.parse(parts[1]),
  //               int.parse(parts[2]),
  //             );
  //             return parsedDate.isAfter(now);
  //           } catch (_) {
  //             return false;
  //           }
  //         }).toList()
  //         ..sort((a, b) {
  //           final aParts = a.date.split('_').first.trim().split('-');
  //           final bParts = b.date.split(' _').first.trim().split('-');
  //           return DateTime(
  //             int.parse(aParts[0]),
  //             int.parse(aParts[1]),
  //             int.parse(aParts[2]),
  //           ).compareTo(
  //             DateTime(
  //               int.parse(bParts[0]),
  //               int.parse(bParts[1]),
  //               int.parse(bParts[2]),
  //             ),
  //           );
  //         });
  //   return upcoming.take(3).toList();
  // }
  List<EventModel> getUpcomingEvents() {
    final now = DateTime.now();
    final upcoming = allEvents.where((event) {
      final isPublic = event.type == 'Public';
      final isPrivateAndUserIsGuest =
          event.type == 'Private' && event.guests!.contains(userId);

      if (!isPublic && !isPrivateAndUserIsGuest) return false;

      try {
        final parts = event.date.split('_').first.trim().split('-');
        final parsedDate = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
        return parsedDate.isAfter(now);
      } catch (_) {
        return false;
      }
    }).toList()
      ..sort((a, b) {
        final aParts = a.date.split('_').first.trim().split('-');
        final bParts = b.date.split('_').first.trim().split('-');
        return DateTime(
          int.parse(aParts[0]),
          int.parse(aParts[1]),
          int.parse(aParts[2]),
        ).compareTo(
          DateTime(
            int.parse(bParts[0]),
            int.parse(bParts[1]),
            int.parse(bParts[2]),
          ),
        );
      });

    return upcoming.take(3).toList();
  }

  List<EventModel> getRecommendedEvents(String currentUserId) {
    final filtered = allEvents.where((event) {
      final isPublic = event.type == 'Public';
      final isPrivateAndUserIsGuest =
          event.type == 'Private' && event.guests!.contains(currentUserId);

      final isNotHost = event.hostId != currentUserId;

      return (isPublic || isPrivateAndUserIsGuest) && isNotHost;
    }).toList()
          ..shuffle();
    return filtered.take(5).toList();
  }
}
