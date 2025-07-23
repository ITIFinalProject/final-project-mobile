// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/add_event/add_event_view.dart';
// import 'package:eventify_app/features/events/events_view.dart';
// import 'package:eventify_app/features/messages/messages_view.dart';
// import 'package:eventify_app/features/profile/profile_view.dart';
// import 'package:flutter/material.dart';
//
// import '../home/home_view.dart';
//
// class LayoutView extends StatefulWidget {
//   const LayoutView({super.key});
//
//   @override
//   State<LayoutView> createState() => _LayoutViewState();
// }
//
// class _LayoutViewState extends State<LayoutView> {
//   final List<Widget> pages = [
//     HomeView(),
//     EventsView(),
//     AddEventView(),
//     MessagesView(),
//     ProfileView(),
//   ];
//
//   int cIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[cIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: cIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//             activeIcon: selectedIcon(Icons.home_outlined),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event_note_sharp),
//             label: 'Events',
//             activeIcon: selectedIcon(Icons.event_note_sharp),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle_outline),
//             label: 'add_event',
//             activeIcon: selectedIcon(Icons.add_circle_outline),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'messages',
//             activeIcon: selectedIcon(Icons.message),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//             activeIcon: selectedIcon(Icons.person),
//           ),
//         ],
//         onTap: (index) {
//           cIndex = index;
//           setState(() {});
//         },
//       ),
//     );
//   }
//
//   Widget selectedIcon(IconData icon) {
//     return CircleAvatar(
//       backgroundColor: ThemeManager.lightPinkColor,
//       child: Icon(icon, color: ThemeManager.secondaryColor, size: 28),
//     );
//   }
// }
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/add_event_view.dart';
import 'package:eventify_app/features/events/events_view.dart';
import 'package:eventify_app/features/messages/messages_view.dart';
import 'package:eventify_app/features/profile/profile_view.dart';
import 'package:flutter/material.dart';

import '../home/home_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final List<Widget> pages = [
    HomeView(),
    EventsView(),
    AddEventView(),
    MessagesView(),
    ProfileView(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: ThemeManager.primaryColor,
        buttonBackgroundColor: ThemeManager.darkPinkColor.withAlpha(255),
        index: currentIndex,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            color:
                currentIndex == 0
                    ? ThemeManager.primaryColor
                    : ThemeManager.darkPinkColor,
            size: 30,
          ),
          Icon(
            Icons.event_note_outlined,
            color:
                currentIndex == 1
                    ? ThemeManager.primaryColor
                    : ThemeManager.darkPinkColor,
            size: 30,
          ),
          Icon(
            Icons.add_circle_outline,
            color:
                currentIndex == 2
                    ? ThemeManager.primaryColor
                    : ThemeManager.darkPinkColor,
            size: 30,
          ),
          Icon(
            Icons.message_outlined,
            color:
                currentIndex == 3
                    ? ThemeManager.primaryColor
                    : ThemeManager.darkPinkColor,
            size: 30,
          ),
          Icon(
            Icons.person_outline,
            color:
                currentIndex == 4
                    ? ThemeManager.primaryColor
                    : ThemeManager.darkPinkColor,
            size: 30,
          ),
        ],
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
