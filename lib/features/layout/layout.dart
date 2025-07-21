import 'package:eventify_app/features/Home.dart';
import 'package:eventify_app/features/add_event/add_event_view.dart';
import 'package:eventify_app/features/events/events_view.dart';
import 'package:eventify_app/features/messages/messages_view.dart';
import 'package:eventify_app/features/profile/profile_view.dart';
import 'package:flutter/material.dart';

class LayoutView extends StatefulWidget {
  LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final List<Widget> pages = [
    HomeView(),
    EventsView(),
    AddEventView(),
    MessagesView(),
    ProfileView()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note_sharp), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'add_event'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          currentIndex = index;
          setState(() {

          });
        },),
    );
  }
}
