// // import 'package:eventify_app/core/theme.dart';
// // import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
// // import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
// // import 'package:flutter/material.dart';

// // class CreateContact extends StatelessWidget {
// //   final GlobalKey<FormState> _formKey = GlobalKey();

// //   TextEditingController nameController = TextEditingController();

// //   CreateContact({super.key});
// //   @override
// //   Widget build(BuildContext context) {
// //     var size = MediaQuery
// //         .of(context)
// //         .size;
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Create Contact'),
// //         centerTitle: true,
// //         leading: Icon(
// //           Icons.person_add_alt_rounded, color:Colors.white,),
// //         actions: [
// //           IconButton(onPressed: () {
// //             Navigator.pop(context);
// //           },
// //               icon: Icon(Icons.clear, color:Colors.white))
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               CustomText(title: 'Name'),
// //               CustomTextFormField(
// //                 controller: nameController,
// //                 hint: 'Enter name',
// //                 validator: (val) {
// //                   if (val == null || val.isEmpty) {
// //                     return 'Please enter name';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               CustomText(title: 'E-mail Address'),
// //               CustomTextFormField(
// //                 controller: nameController,
// //                 hint: 'Enter e-mail address',
// //                 validator: (val) {
// //                   if (val == null || val.isEmpty) {
// //                     return 'Please enter e-mail address';
// //                   } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(val)) {
// //                     return '';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               CustomText(title: 'Phone'),
// //               CustomTextFormField(
// //                 controller: nameController,
// //                 hint: 'Enter phone',
// //                 validator: (val) {
// //                   if (val == null || val.isEmpty) {
// //                     return 'Please enter phone';
// //                   } else if (!RegExp(r"^01[0125]\d{8}").hasMatch(val)) {
// //                     return 'Please enter a valid phone like 01012345678.';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: size.height * 0.45,),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: [
// //                   CustomElevatedButton(onPressed: () {}, title: ('Cancel')),
// //                   CustomElevatedButton(onPressed: () {}, title: ('Save')),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
// import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';

// class CreateContact extends StatefulWidget {
//   const CreateContact({super.key, required this.capacity});
//    final int capacity; // ✅ استقبلنا الـ capacity

//   @override
//   State<CreateContact> createState() => _CreateContactState();
// }

// class _CreateContactState extends State<CreateContact> {
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   TextEditingController emailController = TextEditingController();
//   Map<String, dynamic>? searchedUser; // المستخدم اللي لقيناه
//   List<Map<String, dynamic>> guests = []; // قائمة الضيوف اللي ضفناهم
//   bool isLoading = false;

//   ///  د البحث عن المستخدم في Firestore
//   Future<void> searchUserByEmail() async {
//     final email = emailController.text.trim();
//     if (email.isEmpty) return;

//     setState(() => isLoading = true);

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();

//       if (snapshot.docs.isNotEmpty) {
//         setState(() {
//           searchedUser = snapshot.docs.first.data();
//         });
//       } else {
//         setState(() {
//           searchedUser = null;
//         });
//       }
//     } catch (e) {
//       print("Error searching user: $e");
//       setState(() {
//         searchedUser = null;
//       });
//     }

//     setState(() => isLoading = false);
//   }

//   ///  دالة لإضافة الضيف
//   void addGuest() {
//       if (guests.length >= widget.capacity) {
//         // 🚫 لو العدد وصل للـ capacity → نمنع الإضافة
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("🚫 Capacity is full! Cannot add more guests.")),
//         );
//         return;
//       }
//     if (searchedUser != null &&
//         !guests.any((g) => g['email'] == searchedUser!['email'])) {
//       setState(() {
//         guests.add(searchedUser!);
//         searchedUser = null;
//         emailController.clear();
//       });
//     }
//   }

//   ///  دالة لحذف الضيف
//   void removeGuest(int index) {
//     setState(() {
//       guests.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Contact'),
//         centerTitle: true,
//         leading: Icon(Icons.person_add_alt_rounded, color: ThemeManager.lightPinkColor),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.clear, color: ThemeManager.lightPinkColor))
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             /// 🟡 Text + TextField للبحث عن إيميل
//             CustomText(title: 'Search by E-mail'),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     controller: emailController,
//                     hint: 'Enter e-mail address',
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'Please enter e-mail address';
//                       } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(val)) {
//                         return 'Enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.search, color: ThemeManager.primaryColor, size: 30),
//                   onPressed: searchUserByEmail,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 10),

//             ///  حالة التحميل
//             if (isLoading)
//               const Center(child: CircularProgressIndicator()),

//             /// لو لقيت المستخدم أظهره
//             if (!isLoading && searchedUser != null)
//               Card(
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   side: BorderSide(color: ThemeManager.primaryColor),
//                 ),
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: ThemeManager.primaryColor,
//                     child: Icon(Icons.person, color: Colors.white),
//                   ),
//                   title: Text(searchedUser!['name'] ?? 'No Name'),
//                   subtitle: Text(searchedUser!['email']),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.add_circle, color: Colors.green),
//                     onPressed: addGuest,
//                   ),
//                 ),
//               ),

//             const SizedBox(height: 20),

//             /// 📜 قائمة الضيوف اللي ضفناهم
//             if (guests.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Added Guests:",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   ...guests.map((guest) {
//                     int index = guests.indexOf(guest);
//                     return Card(
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: ThemeManager.secondaryColor,
//                           child: Icon(Icons.person, color: Colors.white),
//                         ),
//                         title: Text(guest['name'] ?? 'No Name'),
//                         subtitle: Text(guest['email']),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.remove_circle, color: Colors.red),
//                           onPressed: () => removeGuest(index),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               )
//             else
//               const Center(child: Text("No guests added yet.")),

//             SizedBox(height: size.height * 0.1),

//             /// ✅ أزرار Save/Cancel
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 CustomElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     title: ('Cancel')),
//                 CustomElevatedButton(
//                     onPressed: () {
//                       // هنا ممكن ترسلي guests للـ Firestore لو حبيتي
//                       print("Guests: $guests");
//                       Navigator.pop(context);
//                     },
//                     title: ('Save')),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'package:eventify_app/features/add_event/logic/invite_state_cubit/invite_cubit.dart';
import 'package:eventify_app/features/add_event/logic/invite_state_cubit/invite_state.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import '../../../core/theme.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class CreateContact extends StatefulWidget {
  // final int capacity;
  final EventModel event;

  const CreateContact({super.key, required this.event});

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();

  List<String> guestEmails = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<CreateEventCubit, CreateEventState>(
      listener: (context, state) {
        if (state is CreateEventSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invitations sent successfully ✅")),
          );
          Navigator.pop(context);
        } else if (state is CreateEventError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Contact'),
            centerTitle: true,
            leading: Icon(
              Icons.person_add_alt_rounded,
              color: ThemeManager.lightPinkColor,
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.clear, color: ThemeManager.lightPinkColor),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(title: 'Guest Email'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: CustomTextFormField(
                        //     controller: emailController,
                        //     hint: 'Enter guest email',
                        //     validator: (val) {
                        //       if (val == null || val.isEmpty) {
                        //         return 'Please enter email';
                        //       } else if (!RegExp(
                        //         r"^[^@]+@[^@]+\.[^@]+",
                        //       ).hasMatch(val)) {
                        //         return 'Invalid email';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        Expanded(
                          child: TypeAheadField<Map<String, dynamic>>(
                            suggestionsCallback: (pattern) async {
                              if (pattern.isEmpty) return [];

                              final snapshot = await FirebaseFirestore.instance
                                  .collection('users')
                                  .where('email', isGreaterThanOrEqualTo: pattern)
                                  .where('email', isLessThanOrEqualTo: pattern + '\uf8ff')
                                  .get();

                              return snapshot.docs.map((doc) => doc.data()).toList();
                            },
                            itemBuilder: (context, Map<String, dynamic> suggestion) {
                              return ListTile(
                                title: Text(suggestion['name'] ?? ''),
                                subtitle: Text(suggestion['email']),
                              );
                            },
                            onSelected: (suggestion) {
                              if (!guestEmails.contains(suggestion['email']) &&
                                  guestEmails.length < widget.event.capacity) {
                                setState(() {
                                  guestEmails.add(suggestion['email']);
                                  emailController.clear();
                                });
                              } else if (guestEmails.length >= widget.event.capacity) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Capacity reached")),
                                );
                              }
                            },

                          ),
                        ),

                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: ThemeManager.primaryColor,
                            size: 35,
                          ),
                          onPressed: () {
                            if (emailController.text.isNotEmpty &&
                                guestEmails.length < widget.event.capacity) {
                              setState(() {
                                guestEmails.add(emailController.text.trim());
                                emailController.clear();
                              });
                            } else if (guestEmails.length >=
                                widget.event.capacity) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Capacity reached ")),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  /// ✅ عرض كل الإيميلات اللي ضفتيها
                  ...guestEmails.map(
                    (email) => ListTile(
                      title: Text(email),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            guestEmails.remove(email);
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.3),

                  ///  زرار Save
                  state is InviteLoading
                      ? Center(child: CircularProgressIndicator())
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            title: ('Cancel'),
                          ),
                          (state is CreateEventLoading)?Center(
                            child: CircularProgressIndicator(),
                          ):
                          CustomElevatedButton(
                            // onPressed: () {
                              // if (guestEmails.isNotEmpty) {
                              //   // context.read<InviteCubit>().sendInvites(
                              //   //       guestEmails,
                              //   //       widget.event,
                              //   //     );
                              //   context.read<CreateEventCubit>().createEvent(
                              //     title: widget.event.title,
                              //     type: widget.event.type,
                              //     description: widget.event.description,
                              //     date: widget.event.date,
                              //     time: widget.event.time,
                              //     location: widget.event.location,
                              //     capacity: widget.event.capacity,
                              //     hostName: widget.event.hostName,
                              //     category: widget.event.category,
                              //     imageFile: File(widget.event.bannerUrl ?? ''),
                              //     templateIndex: widget.event.templateIndex,
                              //     guests: ,
                              //   );
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(
                              //         "Please add at least one guest",
                              //       ),
                              //     ),
                              //   );
                              // }
                              onPressed:
                              () async {
                                if (guestEmails.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please add at least one guest",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                List<UserModel> matchedGuests = [];

                                try {
                                  for (String email in guestEmails) {
                                    final querySnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .where('email', isEqualTo: email)
                                            .get();

                                    if (querySnapshot.docs.isNotEmpty) {
                                      final userData =
                                          querySnapshot.docs.first.data();
                                      final user = UserModel.fromFireStore(userData);
                                      matchedGuests.add(user);
                                    } else {
                                      print(
                                        "❌ User not found for email: $email",
                                      );
                                      // ممكن تتجاهليه أو تعرضي رسالة حسب الحاجة
                                    }
                                  }

                                  if (matchedGuests.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "No valid registered users found.",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<CreateEventCubit>().createEvent(
                                    title: widget.event.title,
                                    type: widget.event.type,
                                    description: widget.event.description,
                                    date: widget.event.date,
                                    time: widget.event.time,
                                    location: widget.event.location,
                                    capacity: widget.event.capacity,
                                    hostName: widget.event.hostName,
                                    category: widget.event.category,

                                    imageFile:
                                     (widget.event.bannerUrl!.isEmpty)?
                                    null : File(widget.event.bannerUrl!),
                                   
                                    templateIndex: widget.event.templateIndex,
                                    guests: matchedGuests,
                                  );
                                  Navigator.pushReplacementNamed(context, AppRoutes.layout);
                                } catch (e) {
                                  print("❌ Error fetching users: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Error fetching guest data",
                                      ),
                                    ),
                                  );
                                };
                              
                            },
                            title: ('Save'),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
