// import 'package:eventify_app/core/theme.dart';
// import 'package:flutter/material.dart';

// import '../../../core/routes.dart';

// class EventCategories extends StatelessWidget {
//   const EventCategories({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final categories = [
//       "Entertainment",
//       "Educational & Business",
//       "Cultural & Arts",
//       "Sports & Fitness",
//       "Technology & Innovation",
//       "Travel & Adventure",
//     ];
//     final icons = [
//       Icons.movie,
//       Icons.business_center,
//       Icons.palette,
//       Icons.sports,
//       Icons.memory,
//       Icons.travel_explore,
//     ];
//     return SizedBox(
//       height: size.height * 0.1,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 10),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap:
//                 () => Navigator.pushNamed(
//                   context,
//                   AppRoutes.categoryEvents,
//                   arguments: categories[index],
//                 ),
//             child: Container(
//               alignment: Alignment.center,
//               height: size.height * 0.08,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: ThemeManager.secondaryColor,
//                   width: 1.5,
//                 ),
//                 gradient: LinearGradient(
//                   begin:
//                       index % 2 == 0
//                           ? Alignment.bottomRight
//                           : Alignment.topRight,
//                   end:
//                       index % 2 != 0 ? Alignment.topLeft : Alignment.centerLeft,
//                   transform: GradientRotation((index + 1) * 90),
//                   colors: [Colors.white, Colors.deepOrange.shade300],
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     icons[index],
//                     color: ThemeManager.primaryColor,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 6),
//                   Text(
//                     categories[index],
//                     style: TextStyle(
//                       color: ThemeManager.primaryColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';

import '../../../core/routes.dart';

class EventCategories extends StatelessWidget {
  const EventCategories({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final categories = [
      "Entertainment",
      "Educational & Business",
      "Cultural & Arts",
      "Sports & Fitness",
      "Technology & Innovation",
      "Travel & Adventure",
      "All Events",
    ];
    final icons = [
      Icons.movie,
      Icons.business_center,
      Icons.palette,
      Icons.sports,
      Icons.memory,
      Icons.travel_explore,
      Icons.event_available,
    ];
    final gradients = [
      [Color.fromARGB(255, 253, 193, 175), Color(0xFFFF8C69)],
      [Color.fromARGB(255, 204, 218, 255), Color(0xFF94ADFF)],
      [Color(0xFFB5A4FF), Color.fromARGB(255, 207, 201, 255)],
      [Color(0xFFFFAE6D), Color(0xFFFFC19E)],
      [Color.fromARGB(255, 151, 166, 175), Color(0xFFFFC19E)],
      [Color.fromARGB(255, 201, 161, 191), Color.fromARGB(255, 173, 109, 153)],
      [Color(0xFFFFAE6D), Color(0xFFFFC19E)],
    ];
    return SizedBox(
      height: size.height * 0.19,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:
            (categories[index]=="All Events")?
              
            () => Navigator.pushNamed(
                  context,
                  AppRoutes.categoryEvents,
                  arguments: categories,
                )
               : () => Navigator.pushNamed(
                  context,
                  AppRoutes.categoryEvents,
                  arguments: categories[index],
                ),
            child: Container(
              width: 150, // كده يخليه شبه مربع
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // زوايا ناعمة
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradients[index],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[index], color: Colors.white, size: 28),
                  const SizedBox(height: 10),
                  Text(
                    categories[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

