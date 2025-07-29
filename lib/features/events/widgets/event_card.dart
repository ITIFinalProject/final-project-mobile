// import 'package:eventify_app/core/routes.dart';
// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/models.dart/event_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class CardEvent extends StatelessWidget {
//   final EventModel event;
//   final VoidCallback? onEdit;
//   final VoidCallback? onDelete;

//   const CardEvent({super.key, required this.event, this.onEdit, this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final imageUrl = event.image;
//     final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//     final isMyEvent = event.hostId == currentUserId;

//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, AppRoutes.eventPreview, arguments: event);
//       },
//       child: Card(
//         color: ThemeManager.lightPinkColor,
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//           side: BorderSide(color: ThemeManager.secondaryColor),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child:
//                     imageUrl != null && imageUrl.isNotEmpty
//                         ? Image.network(
//                           imageUrl,
//                           width: size.width * 0.35,
//                           height: size.height * 0.15,
//                           fit: BoxFit.cover,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;

//                             return Center(
//                               child: CircularProgressIndicator(
//                                 color: ThemeManager.primaryColor,
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             return Icon(Icons.error, color: Colors.red);
//                           },
//                         )
//                         : Image.asset(
//                           'assets/images/template${event.templateIndex}.jpg',
//                           width: size.width * 0.35,
//                           height: size.height * 0.15,
//                           fit: BoxFit.cover,
//                         ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       event.title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: ThemeManager.primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.access_time,
//                           size: 16,
//                           color: Colors.black54,
//                         ),
//                         const SizedBox(width: 5),
//                         Text(event.time.split('-')[0]),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           size: 16,
//                           color: Colors.black54,
//                         ),
//                         const SizedBox(width: 5),
//                         Text(event.date.split('-')[0]),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           size: 16,
//                           color: Colors.black54,
//                         ),
//                         const SizedBox(width: 5),
//                         Expanded(
//                           child: Text(
//                             event.location,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                      if (isMyEvent) ...[
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     // زر Edit
//                     TextButton.icon(
//                       onPressed: onEdit,
//                       icon: Icon(Icons.edit, color: Colors.blue),
//                       label: Text("Edit"),
//                     ),
//                     const SizedBox(width: 8),
//                     // زر Delete
//                     TextButton.icon(
//                       onPressed: onDelete,
//                       icon: Icon(Icons.delete, color: Colors.red),
//                       label: Text("Delete"),
//                     ),
//                   ],
//                 ),
//               ],

//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CardEvent({super.key, required this.event, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final isMyEvent = event.hostId == currentUserId;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.eventPreview, arguments: event);
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child:
                  event.image != null && event.image!.isNotEmpty
                      ? Image.network(
                        event.image!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 180,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ThemeManager.primaryColor,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                      : Image.asset(
                        'assets/images/template${event.templateIndex}.jpg',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: ThemeManager.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            event.date.split('-')[0],
                            style: const TextStyle(
                              fontSize: 14,
                              color: ThemeManager.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: ThemeManager.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            event.time.split('-')[0],
                            style: const TextStyle(
                              fontSize: 14,
                              color: ThemeManager.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  //  المكان
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: ThemeManager.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: ThemeManager.primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (isMyEvent) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: const Icon(
                            Icons.edit,
                            color: ThemeManager.primaryColor,
                          ),
                          onPressed: onEdit,
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF1B3C53).withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          label: const Text(
                            "Edit",
                            style: TextStyle(color: ThemeManager.primaryColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                        //  زر Delete
                        TextButton.icon(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: onDelete,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          label: const Text("Delete"),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ThemeManager.primaryColor,
                                const Color.fromARGB(255, 163, 188, 196),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.event_seat_outlined,
                              color: Colors.white,
                            ),
                            onPressed: onEdit,
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent, // ✅
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            label: const Text(
                              "Join",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
