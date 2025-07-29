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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String name = "";

  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      name = authState.user.name ?? '';
    }
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
                allEvents =
                    state.filteredEvents.isEmpty && searchText.isEmpty
                        ? state.allEvents
                        : state.filteredEvents;
                userId = FirebaseAuth.instance.currentUser!.uid;
                final recommendedEvents = getRecommendedEvents(userId);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isNotEmpty ? "Welcome, $name! 👋" : "Welcome!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SearchInputField(
                        onChange: (value) {
                          searchText = value;
                          context.read<HomeCubit>().search(value);
                        },
                      ),
                      if (searchText.isNotEmpty)
                        allEvents.isNotEmpty
                            ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: allEvents.length,
                              itemBuilder: (context, index) {
                                final event = allEvents[index];
                                return ListTile(
                                  title: Text(event.title),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.eventPreview,
                                      arguments: event,
                                    );
                                  },
                                );
                              },
                            )
                            : const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("No results found."),
                            ),
                      const SizedBox(height: 20),
                      const EventCategories(),
                      const SizedBox(height: 20),
                      Text(
                        'Upcoming Events',
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
                        'Recommended Events',
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
}
