import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/features/events/event_cubit/event_state.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import '../floating_button/chatscreen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


 List<EventModel> getUpcomingEvents() {
    final now = DateTime.now();

    final upcoming = allEvents.where((event) {
      try {
        final dateRange = event.date.split(' - ').first.trim();
        final parts = dateRange.split('/');
        final parsedDate = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );

        return parsedDate.isAfter(now);
      } catch (e) {
        return false;
      }
    }).toList();

    upcoming.sort((a, b) {
      final aDateParts = a.date.split(' - ').first.trim().split('/');
      final bDateParts = b.date.split(' - ').first.trim().split('/');

      final aDate = DateTime(
        int.parse(aDateParts[2]),
        int.parse(aDateParts[1]),
        int.parse(aDateParts[0]),
      );

      final bDate = DateTime(
        int.parse(bDateParts[2]),
        int.parse(bDateParts[1]),
        int.parse(bDateParts[0]),
      );

      return aDate.compareTo(bDate);
    });

    return upcoming.take(3).toList();
  }






  String name = "";
String searchText = '';
final List<String> categories = [
  "Entertainment",
  "Educational & Business",
  "Cultural & Arts",
  "Sports & Fitness",
  "Technology & Innovation",
  "Travel & Adventure",
];


  List<EventModel> allEvents = [];
List<EventModel> filteredEvents = [];

  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      name = authState.user.name ?? '';
    }
     context.read<EventCubit>().fetchEvents();
  }


  void _filterEvents(String query) {
  final filtered = allEvents.where((event) =>
      event.title.toLowerCase().contains(query.toLowerCase())).toList();

  setState(() {
    filteredEvents = filtered;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        if (state is EventLoaded) {
          allEvents = state.events;
        }
        return const SizedBox(); 
      },
    ),
              Text(
                name.isNotEmpty ? "Welcome, $name!" : "Welcome!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
  onChanged: (value) {
    setState(() {
      searchText = value;
      filteredEvents = allEvents
          .where((event) =>
              event.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  },
  decoration: InputDecoration(
    hintText: 'Search',
    prefixIcon: Icon(Icons.search),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Color(0xFF1B3C53), 
        width: 2,
      ),
    ),
  ),
),


searchText.isNotEmpty
    ? (filteredEvents.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];
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
          ))
    : const SizedBox(),
   
const SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3C53),
                ),
              ),
             
const SizedBox(height: 10),
SizedBox(
  height: 50,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      final category = categories[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.categoryEvents,
              arguments: category,
            );
          },
          child: Chip(
            label: Text(
              category,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: Colors.blue.shade100,
          ),
        ),
      );
    },
  ),
),



const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Now that you are all set.\nLet's make your events extraordinary,\nstarting right here!",
                      style: TextStyle(fontSize: 14, color: Color(0xFF456882)),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.realEventDetails,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 54,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ), child: const Text(
                      'Plan an Event',
                      style: TextStyle(color: Colors.white),
                    ),
                    ),
                  ],
                ),
              ),
             
              const SizedBox(height: 60),
              

              const Text(
  'Upcoming Events',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1B3C53),
  ),
),
const SizedBox(height: 20),


...getUpcomingEvents().map((event) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: event.image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.image!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(Icons.event),
        title: Text(
          event.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "${event.date} - ${event.location}",
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.eventPreview,
            arguments: event,
          );
        },
      ),
    ),
  );
}).toList(),




if (getUpcomingEvents().isEmpty)
  const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      "No upcoming events. Create one now!",
      style: TextStyle(fontSize: 13, color: Color(0xFF456882)),
    ),
  ),

              
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatScreen()),
          );
        },
        backgroundColor: const Color(0xFF1B3C53),
        elevation: 6,
        shape: const CircleBorder(),
        child: SvgPicture.asset(
          'assets/images/ChatGPT-Logo.svg',
          width: 32,
          height: 32,

          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),

      ),
    );
  }
}






