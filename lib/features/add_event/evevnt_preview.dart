// import 'package:eventify_app/core/routes.dart';
// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class EventPreviewPage extends StatelessWidget {
//   const EventPreviewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: const Text("3 of 5: Preview"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 400,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//                 image: const DecorationImage(
//                   image: AssetImage("assets/images/page2.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, AppRoutes.eventDetails);
//                 },
//                 icon: const Icon(Icons.edit, color: ThemeManager.primaryColor),
//                 label: const Text(
//                   "Edit Details",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: ThemeManager.primaryColor,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ThemeManager.darkPinkColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//             const Text(
//               "Family Get-Together",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: ThemeManager.primaryColor,
//               ),
//             ),

//             const SizedBox(height: 8),
//             Row(
//               children: const [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: ThemeManager.secondaryColor,
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   "Wednesday, 6 Dec 2023 | 3:30 pm - 5:00 pm",
//                   style: TextStyle(color: ThemeManager.secondaryColor),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 4),

//             TextButton.icon(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.calendar_today,
//                 size: 18,
//                 color: ThemeManager.primaryColor,
//               ),
//               label: const Text(
//                 "Add to Calendar",
//                 style: TextStyle(color: ThemeManager.primaryColor),
//               ),
//             ),

//             const SizedBox(height: 8),

//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Icon(
//                   Icons.location_on_outlined,
//                   size: 20,
//                   color: ThemeManager.secondaryColor,
//                 ),
//                 SizedBox(width: 6),
//                 Expanded(
//                   child: Text(
//                     "AB7, Valar Kottai, Near Lathiya Auditorium, Vennadu, North, Kerala-682013",
//                     style: TextStyle(color: ThemeManager.secondaryColor),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 30),

//             Row(
//               children: const [
//                 Icon(
//                   Icons.person_outline,
//                   color: ThemeManager.primaryColor,
//                   size: 20,
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   "Hosted By",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: ThemeManager.primaryColor,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 4),
//             const Text(
//               "Dylan Thomas",
//               style: TextStyle(color: ThemeManager.secondaryColor),
//             ),

//             const SizedBox(height: 20),
//             const Text(
//               "Event Description",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: ThemeManager.primaryColor,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               "Join us for a joyful celebration of faith, family, and fellowship at our annual Parish Feast Family Get-Together! Let us spend quality time with each other and create warm memories that will last a lifetime.",
//               style: TextStyle(color: ThemeManager.secondaryColor),
//             ),

//             const SizedBox(height: 20),
//             const Text(
//               "Guest List",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: ThemeManager.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               decoration: BoxDecoration(
//                 color: ThemeManager.lightPinkColor,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),

//               child: const Column(
//                 children: [
//                   ListTile(
//                     title: Text(
//                       "Guest Name",
//                       style: TextStyle(color: ThemeManager.primaryColor),
//                     ),
//                     trailing: Text(
//                       "1 Guest",
//                       style: TextStyle(color: ThemeManager.secondaryColor),
//                     ),
//                   ),
//                   Divider(height: 1),
//                   ListTile(
//                     title: Text(
//                       "Guest Name",
//                       style: TextStyle(color: ThemeManager.primaryColor),
//                     ),
//                     trailing: Text(
//                       "2 Guests",
//                       style: TextStyle(color: ThemeManager.secondaryColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: CustomElevatedButton(
//                 onPressed: () {
//                   HapticFeedback.lightImpact();
//                   Navigator.pushNamed(context, AppRoutes.createContacts);
//                 },
//                 title: "Next: Add Guests",
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
import 'package:flutter/material.dart';

class EventPreviewPage extends StatelessWidget {
  const EventPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.asset(
                'assets/images/page2.jpg',
                height: 400,
                width: double.infinity,
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
                        const Text(
                          "Family Get-Together",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1b3c53),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.eventDetails);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: ThemeManager.primaryColor,
                          ),
                          label: const Text(
                            "Edit Details",
                            style: TextStyle(
                              fontSize: 16,
                              color: ThemeManager.primaryColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeManager.darkPinkColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                
                    const SizedBox(height: 16),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         _InfoBox(icon: Icons.date_range, label: "(Monday)Dec 28 |Dec 30 "),
                        _InfoBox(icon: Icons.access_time, label: "8:45pm | 11pm"),
                       
                      ],
                    ),
                
                    const SizedBox(height: 16),
                
                      Row(
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: ThemeManager.secondaryColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "El-Gezira Club, Zamalek",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff1b3c53),
                          ),
                        ),
                      ],
                    ),
                
                    
                
                    const SizedBox(height: 24),
                
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today_outlined, size: 18,color: ThemeManager.primaryColor,),
                      label: const Text("Add to calendar"),
                      style: TextButton.styleFrom(
                        foregroundColor: ThemeManager.primaryColor,
                        backgroundColor: ThemeManager.lightPinkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 24),
                
                    const Text(
                      "Hosted by:",
                      style: TextStyle(fontWeight: FontWeight.bold,color: ThemeManager.primaryColor),
                    ),
                    const SizedBox(height: 8),
                    const Text("Asmaa Mousa",style: TextStyle(color: ThemeManager.secondaryColor),),
                
                    const SizedBox(height: 24),
                
                    const Text(
                      "Event Description:",
                      style: TextStyle(fontWeight: FontWeight.bold, color: ThemeManager.primaryColor),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Join us for an unforgettable evening with friends and family. Enjoy good food, great company, and lasting memories!",
                      style: TextStyle(fontSize: 14,
                      color: ThemeManager.secondaryColor
                      ),
                    ),
                
                    const SizedBox(height: 24),
                
                    const Text(
                      "Guest List:",
                      style: TextStyle(fontWeight: FontWeight.bold,
                      color: ThemeManager.primaryColor
                      ),
                    ),
                    const SizedBox(height: 12),
                
                    Row(
                      children: const [
                        CircleAvatar(child: Text("A")),
                        SizedBox(width: 8),
                        CircleAvatar(child: Text("B")),
                        SizedBox(width: 8),
                        CircleAvatar(child: Text("C")),
                        SizedBox(width: 8),
                        CircleAvatar(child: Text("+9")),
                      ],
                    ),
                
                    const SizedBox(height: 32),
                
                    SizedBox(
                     width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.addGuest);
                        },
                        icon: const Icon(Icons.group_add, color: ThemeManager.lightPinkColor),
                        label: const Text("Invite Guests"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeManager.primaryColor,
                          foregroundColor:ThemeManager.lightPinkColor ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            
                          ),
                          
                        
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Widget _InfoBox({required IconData icon, required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xfff9f3ef),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color:ThemeManager.primaryColor),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color:ThemeManager.primaryColor)),
      ],
    ),
  );
}
