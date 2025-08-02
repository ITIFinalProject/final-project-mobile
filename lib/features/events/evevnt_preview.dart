// // import 'package:eventify_app/core/routes.dart';
// // import 'package:eventify_app/core/theme.dart';
// // import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
//
// // class EventPreviewPage extends StatelessWidget {
// //   const EventPreviewPage({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: const BackButton(),
// //         title: const Text("3 of 5: Preview"),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               height: 400,
// //               width: double.infinity,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black12,
// //                     blurRadius: 6,
// //                     offset: Offset(0, 2),
// //                   ),
// //                 ],
// //                 image: const DecorationImage(
// //                   image: AssetImage("assets/images/page2.jpg"),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
//
// //             const SizedBox(height: 12),
// //             Align(
// //               alignment: Alignment.centerRight,
// //               child: ElevatedButton.icon(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, AppRoutes.eventDetails);
// //                 },
// //                 icon: const Icon(Icons.edit, color: ThemeManager.primaryColor),
// //                 label: const Text(
// //                   "Edit Details",
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     color: ThemeManager.primaryColor,
// //                   ),
// //                 ),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: ThemeManager.darkPinkColor,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                 ),
// //               ),
// //             ),
//
// //             const SizedBox(height: 16),
// //             const Text(
// //               "Family Get-Together",
// //               style: TextStyle(
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.bold,
// //                 color: ThemeManager.primaryColor,
// //               ),
// //             ),
//
// //             const SizedBox(height: 8),
// //             Row(
// //               children: const [
// //                 Icon(
// //                   Icons.calendar_today_outlined,
// //                   size: 16,
// //                   color: ThemeManager.secondaryColor,
// //                 ),
// //                 SizedBox(width: 6),
// //                 Text(
// //                   "Wednesday, 6 Dec 2023 | 3:30 pm - 5:00 pm",
// //                   style: TextStyle(color: ThemeManager.secondaryColor),
// //                 ),
// //               ],
// //             ),
//
// //             const SizedBox(height: 4),
//
// //             TextButton.icon(
// //               onPressed: () {},
// //               icon: const Icon(
// //                 Icons.calendar_today,
// //                 size: 18,
// //                 color: ThemeManager.primaryColor,
// //               ),
// //               label: const Text(
// //                 "Add to Calendar",
// //                 style: TextStyle(color: ThemeManager.primaryColor),
// //               ),
// //             ),
//
// //             const SizedBox(height: 8),
//
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: const [
// //                 Icon(
// //                   Icons.location_on_outlined,
// //                   size: 20,
// //                   color: ThemeManager.secondaryColor,
// //                 ),
// //                 SizedBox(width: 6),
// //                 Expanded(
// //                   child: Text(
// //                     "AB7, Valar Kottai, Near Lathiya Auditorium, Vennadu, North, Kerala-682013",
// //                     style: TextStyle(color: ThemeManager.secondaryColor),
// //                   ),
// //                 ),
// //               ],
// //             ),
//
// //             const SizedBox(height: 30),
//
// //             Row(
// //               children: const [
// //                 Icon(
// //                   Icons.person_outline,
// //                   color: ThemeManager.primaryColor,
// //                   size: 20,
// //                 ),
// //                 SizedBox(width: 6),
// //                 Text(
// //                   "Hosted By",
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     color: ThemeManager.primaryColor,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //               ],
// //             ),
//
// //             const SizedBox(height: 4),
// //             const Text(
// //               "Dylan Thomas",
// //               style: TextStyle(color: ThemeManager.secondaryColor),
// //             ),
//
// //             const SizedBox(height: 20),
// //             const Text(
// //               "Event Description",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: ThemeManager.primaryColor,
// //                 fontSize: 18,
// //               ),
// //             ),
// //             const SizedBox(height: 4),
// //             const Text(
// //               "Join us for a joyful celebration of faith, family, and fellowship at our annual Parish Feast Family Get-Together! Let us spend quality time with each other and create warm memories that will last a lifetime.",
// //               style: TextStyle(color: ThemeManager.secondaryColor),
// //             ),
//
// //             const SizedBox(height: 20),
// //             const Text(
// //               "Guest List",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: ThemeManager.primaryColor,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: ThemeManager.lightPinkColor,
// //                 borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black12,
// //                     blurRadius: 6,
// //                     offset: Offset(0, 2),
// //                   ),
// //                 ],
// //               ),
//
// //               child: const Column(
// //                 children: [
// //                   ListTile(
// //                     title: Text(
// //                       "Guest Name",
// //                       style: TextStyle(color: ThemeManager.primaryColor),
// //                     ),
// //                     trailing: Text(
// //                       "1 Guest",
// //                       style: TextStyle(color: ThemeManager.secondaryColor),
// //                     ),
// //                   ),
// //                   Divider(height: 1),
// //                   ListTile(
// //                     title: Text(
// //                       "Guest Name",
// //                       style: TextStyle(color: ThemeManager.primaryColor),
// //                     ),
// //                     trailing: Text(
// //                       "2 Guests",
// //                       style: TextStyle(color: ThemeManager.secondaryColor),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
//
// //             const SizedBox(height: 24),
// //             SizedBox(
// //               width: double.infinity,
// //               child: CustomElevatedButton(
// //                 onPressed: () {
// //                   HapticFeedback.lightImpact();
// //                   Navigator.pushNamed(context, AppRoutes.createContacts);
// //                 },
// //                 title: "Next: Add Guests",
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventify_app/core/routes.dart';
// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/add_memory/view/add_memory.dart';
// import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
// import 'package:eventify_app/features/auth/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../models.dart/event_model.dart';
// import '../add_event/edit event/edit_event_view.dart';
// import '../auth/cubit/auth_state.dart';
// import 'event_cubit/event_cubit.dart';
// import 'event_cubit/event_state.dart';
//
// class EventPreviewPage extends StatelessWidget {
//   const EventPreviewPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments;
//
//     if (args == null || args is! EventModel) {
//       return const Scaffold(
//         body: Center(child: Text("No event data provided.")),
//       );
//     }
//     var event = args;
//     var size = MediaQuery.of(context).size;
//     String? imageUrl = event.bannerUrl;
//     var date;
//     if (event.date.contains('_')) {
//       date = event.date.split('_').first;
//     } else {
//       date = event.date;
//     }
//     DateTime? eventDateTime;
//     try {
//       final timePart = event.time.split('-').first.trim(); // "01:03 AM"
//       final formattedString = "$date$timePart"; // "2025-08-04 01:03 AM"
//       eventDateTime = DateTime.parse(formattedString);
//       print("Parsed event time: $eventDateTime");
//     } catch (e) {
//       print("Error parsing event time: $e");
//     }
//     print(DateTime.now());
//     bool isPast =
//         eventDateTime != null && DateTime.now().isAfter(eventDateTime);
//     print(isPast);
//     bool isUpcoming =
//         eventDateTime != null && DateTime.now().isBefore(eventDateTime!);
//
//   return  BlocListener<AuthCubit, AuthState>(
//         listener: (context, authState) {
//           if (authState is AuthSuccess) {
//             context.read<EventCubit>().fetchJoinedEvents();
//           }
//         },
//     child:  Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(backgroundColor: ThemeManager.primaryColor),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(24),
//                 bottomRight: Radius.circular(24),
//               ),
//               child:
//                   imageUrl != null && imageUrl.isNotEmpty
//                       ? Image.network(
//                         imageUrl,
//                         width: size.width,
//                         height: size.height * 0.4,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//
//                           return Center(
//                             child: CircularProgressIndicator(
//                               color: ThemeManager.primaryColor,
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error, stackTrace) {
//                           return Icon(Icons.error, color: Colors.red);
//                         },
//                       )
//                       : Image.asset(
//                         'assets/images/template${event.templateIndex}.jpg',
//                         width: size.width,
//                         height: size.height * 0.4,
//                         fit: BoxFit.cover,
//                       ),
//             ),
//
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           event.title,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff1b3c53),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     _InfoBox(icon: Icons.date_range, label: event.date),
//                     const SizedBox(height: 16),
//                     _InfoBox(icon: Icons.access_time, label: event.time),
//
//                     const SizedBox(height: 16),
//
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Icon(
//                           Icons.location_on_outlined,
//                           color: ThemeManager.secondaryColor,
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             event.location,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Color(0xff1b3c53),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 24),
//                     if (event.location.isNotEmpty)
//                       TextButton.icon(
//                         onPressed: () {
//                           final query = Uri.encodeComponent(event.location);
//                           final googleMapsUrl =
//                               'https://www.google.com/maps/search/?api=1&query=$query';
//                           launchUrl(Uri.parse(googleMapsUrl));
//                         },
//                         icon: Icon(Icons.map, color: ThemeManager.primaryColor),
//                         label: Text("Open in Maps"),
//                       ),
//
//                     // TextButton.icon(
//                     //   onPressed: () {},
//                     //   icon: const Icon(
//                     //     Icons.calendar_today_outlined,
//                     //     size: 18,
//                     //     color: ThemeManager.primaryColor,
//                     //   ),
//                     //   label: const Text("Add to calendar"),
//                     //   style: TextButton.styleFrom(
//                     //     foregroundColor: ThemeManager.primaryColor,
//                     //     backgroundColor: ThemeManager.lightPinkColor,
//                     //     shape: RoundedRectangleBorder(
//                     //       borderRadius: BorderRadius.circular(12),
//                     //     ),
//                     //     padding: const EdgeInsets.symmetric(
//                     //       horizontal: 16,
//                     //       vertical: 8,
//                     //     ),
//                     //   ),
//                     // ),
//                     const SizedBox(height: 24),
//
//                     const Text(
//                       "Hosted by:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: ThemeManager.primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       event.hostName,
//                       style: TextStyle(color: ThemeManager.secondaryColor),
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     const Text(
//                       "Event Description:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: ThemeManager.primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       event.description,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: ThemeManager.secondaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     if (event.type.toLowerCase() == "private" &&
//                         event.guests!.isNotEmpty)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Guest List:",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           ...event.guests!.map(
//                             (guest) => ListTile(
//                               leading: Icon(Icons.person_outline),
//                               title: Text(guest.name!),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                     const SizedBox(height: 24),
//
//                     BlocBuilder<AuthCubit, AuthState>(
//                       builder: (context, state) {
//                         if (state is AuthSuccess) {
//                           final currentUser = state.user;
//                           if (event.hostName.trim().toLowerCase() ==
//                               currentUser.name?.split(' ')[0].toLowerCase()) {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               spacing: 10,
//                               children: [
//                                 Expanded(
//                                   child: ElevatedButton.icon(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder:
//                                               (context) =>
//                                                   EditEventView(event: event),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(
//                                       Icons.edit,
//                                       color: ThemeManager.lightPinkColor,
//                                     ),
//                                     label: const Text("Edit"),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor:
//                                           ThemeManager.primaryColor,
//                                       foregroundColor:
//                                           ThemeManager.lightPinkColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: ElevatedButton.icon(
//                                     onPressed: () {},
//                                     icon: const Icon(
//                                       Icons.delete,
//                                       color: Colors.red,
//                                     ),
//                                     label: const Text("Delete"),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.red[100],
//                                       foregroundColor:
//                                           ThemeManager.lightPinkColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } else {
//                             return BlocConsumer<EventCubit, EventState>(
//                               listener: (context, state) {
//                                 if (state is EventJoinSuccess) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text("Joined Successfully"),
//                                     ),
//                                   );
//                                 } else if (state is EventJoinError) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text(state.message)),
//                                   );
//                                 }
//                               },
//                               // builder: (context, state) {
//                               //   return SizedBox(
//                               //     width: double.infinity,
//                               //     child: ElevatedButton.icon(
//                               //       onPressed: () {
//                               //         context.read<EventCubit>().joinEvent(
//                               //           event,
//                               //         );
//                               //       },
//                               //       icon: const Icon(
//                               //         Icons.event_available,
//                               //         color: ThemeManager.lightPinkColor,
//                               //       ),
//                               //       label:
//                               //           state is EventJoinLoading
//                               //               ? const SizedBox(
//                               //                 height: 20,
//                               //                 width: 20,
//                               //                 child: CircularProgressIndicator(
//                               //                   strokeWidth: 2,
//                               //                   color:
//                               //                       ThemeManager.lightPinkColor,
//                               //                 ),
//                               //               )
//                               //               : const Text("Join Event"),
//                               //       style: ElevatedButton.styleFrom(
//                               //         backgroundColor:
//                               //             ThemeManager.secondaryColor,
//                               //         foregroundColor:
//                               //             ThemeManager.lightPinkColor,
//                               //         shape: RoundedRectangleBorder(
//                               //           borderRadius: BorderRadius.circular(30),
//                               //         ),
//                               //       ),
//                               //     ),
//                               //   );
//                               // },
//                               builder: (context, state) {
//                                 if (state is EventLoading) {
//                                   return const Center(
//                                     child: CircularProgressIndicator(color: ThemeManager.primaryColor),
//                                   );
//                                 }
//                                 else if (state is EventJoinedLoaded || state is EventLoaded) {
//                                   final joinedEvents = state.events;
//                                   final hasJoined = (joinedEvents.isEmpty)?false:joinedEvents.any(
//                                     (e) => e.id == event.id,
//                                   );
//
//                                   if (hasJoined && isUpcoming) {
//                                     return _disabledButton("Already Joined");
//                                   } else if (hasJoined && isPast) {
//                                     return _activeButton(
//                                       "Add Memory",
//                                       Icons.add_photo_alternate,
//                                       () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder:
//                                                 (context) =>
//                                                     AddMemory(event: event),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   } }else  {
//                                     return _activeButton(
//                                       "Join Event",
//                                       Icons.event_available,
//                                       () {
//                                         context.read<EventCubit>().joinEvent(
//                                           event,
//                                         );
//                                         context.read<EventCubit>().fetchJoinedEvents();
//                                       },
//                                     );
//                                   }
//                                 // } else {
//                                 //   return SizedBox();
//                                 // }
//                               },
//                             );
//                           }
//                         } else {
//                           return SizedBox();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             if (isPast)
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AddMemory(event: event),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.add_photo_alternate_outlined,color: Colors.white,),
//                     label: Text("Add Memory"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ThemeManager.primaryColor,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     ));
//   }
// }
//
// Widget _InfoBox({required IconData icon, required String label}) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//     decoration: BoxDecoration(
//       color: Color(0xfff9f3ef),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Row(
//       children: [
//         Icon(icon, size: 16, color: ThemeManager.primaryColor),
//         const SizedBox(width: 4),
//         Text(label, style: const TextStyle(color: ThemeManager.primaryColor)),
//       ],
//     ),
//   );
// }
//
// Widget _disabledButton(String label) {
//   return SizedBox(
//     width: double.infinity,
//     child: ElevatedButton(
//       onPressed: null,
//       child: Text(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.grey[400],
//         foregroundColor: Colors.white,
//       ),
//     ),
//   );
// }
//
// Widget _activeButton(String label, IconData icon, VoidCallback onPressed) {
//   return SizedBox(
//     width: double.infinity,
//     child: ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, color: Colors.white),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: ThemeManager.secondaryColor,
//         foregroundColor: Colors.white,
//       ),
//     ),
//   );
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_memory/view/add_memory.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! EventModel) {
      return const Scaffold(
        body: Center(child: Text("No event data provided.")),
      );
    }
    var event = args;
    var size = MediaQuery.of(context).size;
    String? imageUrl = event.bannerUrl;
    var date;
    if (event.date.contains('_')) {
      date = event.date.split('_').first;
    } else {
      date = event.date;
    }
    DateTime? eventDateTime;
    try {
      final timePart = event.time.split('-').first.trim(); // "01:03 AM"
      final formattedString = "$date$timePart"; // "2025-08-04 01:03 AM"
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
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: ThemeManager.primaryColor),
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
                                color: ThemeManager.primaryColor,
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
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
                              color: Color(0xff1b3c53),
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
                            color: ThemeManager.secondaryColor,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff1b3c53),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
                            color: ThemeManager.primaryColor,
                          ),
                          label: Text("Open in Maps"),
                        ),
                      const SizedBox(height: 24),
                      const Text(
                        "Hosted by:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.hostName,
                        style: TextStyle(color: ThemeManager.secondaryColor),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Event Description:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: ThemeManager.secondaryColor,
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
                                leading: Icon(Icons.person_outline),
                                title: Text(guest.name!),
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
                                      icon: const Icon(
                                        Icons.edit,
                                        color: ThemeManager.lightPinkColor,
                                      ),
                                      label: const Text("Edit"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ThemeManager.primaryColor,
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
                                                      ),
                                                      title: Text(
                                                        'Delete Event',
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
                                                          child: Text('Ok'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Text('Cancel'),
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
                                      label: const Text("Delete"),
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
                                      ),
                                    );
                                  } else if (eventState is EventError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Error: ${eventState.message}",
                                        ),
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
                                      return _disabledButton("Already Joined");
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
                                      return _disabledButton("Event is Finished");
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
              // if (isPast)
              //   Center(
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 16),
              //       child: ElevatedButton.icon(
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => AddMemory(event: event),
              //             ),
              //           );
              //         },
              //         icon: const Icon(Icons.add_photo_alternate_outlined,
              //             color: Colors.white),
              //         label: const Text("Add Memory"),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: ThemeManager.primaryColor,
              //           foregroundColor: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
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
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xfff9f3ef),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: ThemeManager.primaryColor),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: ThemeManager.primaryColor)),
      ],
    ),
  );
}

Widget _disabledButton(String label) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.white,
      ),
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
