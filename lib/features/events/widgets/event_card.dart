
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
//     final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//     final isMyEvent = event.hostId == currentUserId;

//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, AppRoutes.eventPreview, arguments: event);
//       },
//       child: Card(
//         elevation: 3,
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(18),
//                   ),
//                   child: event.image != null && event.image!.isNotEmpty
//                       ? Image.network(
//                           event.image!,
//                           height: 180,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               height: 180,
//                               alignment: Alignment.center,
//                               child: CircularProgressIndicator(
//                                 color: ThemeManager.primaryColor,
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 180,
//                               color: Colors.grey[300],
//                               child: const Icon(
//                                 Icons.broken_image,
//                                 size: 50,
//                                 color: Colors.grey,
//                               ),
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           'assets/images/template${event.templateIndex}.jpg',
//                           height: 180,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: GestureDetector(
//                     onTap: () {
                
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.8),
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(6),
//                       child: Icon(
//                         Icons.star_border,
//                         color: ThemeManager.primaryColor,
//                         size: 28,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     event.title,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: ThemeManager.primaryColor,
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.calendar_today,
//                             size: 18,
//                             color: ThemeManager.primaryColor,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             event.date.split('-')[0],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: ThemeManager.primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.access_time,
//                             size: 18,
//                             color: ThemeManager.primaryColor,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             event.time.split('-')[0],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: ThemeManager.primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),

//                   //  المكان
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         size: 18,
//                         color: ThemeManager.primaryColor,
//                       ),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           event.location,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: ThemeManager.primaryColor,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (isMyEvent) ...[
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton.icon(
//                           icon: const Icon(
//                             Icons.edit,
//                             color: ThemeManager.primaryColor,
//                           ),
//                           onPressed: onEdit,
//                           style: TextButton.styleFrom(
//                             backgroundColor: Color(0xFF1B3C53).withOpacity(0.1),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           label: const Text(
//                             "Edit",
//                             style: TextStyle(color: ThemeManager.primaryColor),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         //  زر Delete
//                         TextButton.icon(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.redAccent,
//                           ),
//                           onPressed: onDelete,
//                           style: TextButton.styleFrom(
//                             backgroundColor: Colors.red.withOpacity(0.1),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           label: const Text("Delete"),
//                         ),
//                       ],
//                     ),
//                   ] else ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 ThemeManager.primaryColor,
//                                 const Color.fromARGB(255, 163, 188, 196),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: TextButton.icon(
//                             icon: const Icon(
//                               Icons.event_seat_outlined,
//                               color: Colors.white,
//                             ),
//                             onPressed: onEdit,
//                             style: TextButton.styleFrom(
//                               backgroundColor: Colors.transparent, // ✅
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 10,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             label: const Text(
//                               "Join",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
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

class CardEvent extends StatefulWidget {
  final EventModel event;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isInterested;   // ✅ لو المستخدم مهتم بالحدث (true) أو لا
  final VoidCallback onToggleInterested; // ✅ دالة عند الضغط على النجمة

  const CardEvent({
    super.key,
    required this.event,
    this.onEdit,
    this.onDelete,
     required this.isInterested ,
    required this.onToggleInterested,
  });

  @override
  State<CardEvent> createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final isMyEvent = widget.event.hostId == currentUserId;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.eventPreview, arguments: widget.event);
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟡 الجزء اللي فيه الصورة + زر النجمة
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: widget.event.image != null && widget.event.image!.isNotEmpty
                      ? Image.network(
                          widget.event.image!,
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
                          'assets/images/template${widget.event.templateIndex}.jpg',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),

                // ⭐ زر النجمة
                IconButton(
                  icon: Icon(
                    widget.isInterested ? Icons.star : Icons.star_border,
                    color: widget.isInterested ? Colors.yellow[700] : Colors.white,
                    size: 30,
                  ),
                  onPressed: widget.onToggleInterested,
                ),
              ],
            ),

            // 🟢 باقي تفاصيل الحدث
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 🔵 التاريخ والوقت
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 18, color: ThemeManager.primaryColor),
                          const SizedBox(width: 6),
                          Text(
                            widget.event.date.split('-')[0],
                            style: const TextStyle(
                              fontSize: 14,
                              color: ThemeManager.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 18, color: ThemeManager.primaryColor),
                          const SizedBox(width: 6),
                          Text(
                            widget.event.time.split('-')[0],
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

                  // 🔵 المكان
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: ThemeManager.primaryColor),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.event.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: ThemeManager.primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // 🔵 لو الحدث بتاعي → Edit/Delete
                  if (isMyEvent) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.edit,
                              color: ThemeManager.primaryColor),
                          onPressed: widget.onEdit,
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
                        TextButton.icon(
                          icon: const Icon(Icons.delete,
                              color: Colors.redAccent),
                          onPressed: widget.onDelete,
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
                    // 🔵 لو الحدث مش بتاعي → زر Join
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
                            icon: const Icon(Icons.event_seat_outlined,
                                color: Colors.white),
                            onPressed: widget.onEdit,
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
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
