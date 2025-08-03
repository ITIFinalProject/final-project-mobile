import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'package:eventify_app/features/add_event/logic/invite_state_cubit/invite_cubit.dart';
import 'package:eventify_app/features/add_event/logic/invite_state_cubit/invite_state.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
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
     final thememode = context.watch<ThemeCubit>().state;
    final isDarkMode = thememode == ThemeMode.dark;

    
    var size = MediaQuery.of(context).size;

    return BlocConsumer<CreateEventCubit, CreateEventState>(
      
      listener: (context, state) {
        if (state is CreateEventSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invitations sent successfully ✅"),
              backgroundColor:Colors.green ,
            ),
          );
          Navigator.pop(context);
        } else if (state is CreateEventError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message),
          backgroundColor:Colors.red ,
          ),
          
          );
        }
      },
      builder: (context, state) {

        return Scaffold(
          
          appBar: AppBar(
            title: Text('Create Contact'),
            centerTitle: true,
           
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(title: 'Guest Email'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 16),
                    child: Expanded(
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
                              SnackBar(content: Text("Capacity reached"),
                              
                              backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                    
                      ),
                    ),
                  ),

                  /// ✅ عرض كل الإيميلات اللي ضفتيها
                  ...guestEmails.map(
                    (email) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                      child: ListTile(
                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color:isDarkMode?ThemeManager.lightPinkColor:ThemeManager.primaryColor, ),
                        ),
                        title: Text(email,style: TextStyle(
                          color: isDarkMode?ThemeManager.lightPinkColor:ThemeManager.primaryColor,
                        )),
                        
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
                  ),

                  SizedBox(height: size.height * 0.3),

                  ///  زرار Save
                  state is InviteLoading
                      ? Center(child: CircularProgressIndicator(
                        color: isDarkMode?ThemeManager.lightPinkColor: ThemeManager.primaryColor,
                      ))
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            title: ('Cancel'),
                          ),
                          (state is CreateEventLoading)?Center(
                            child: CircularProgressIndicator(
                              color: isDarkMode?ThemeManager.lightPinkColor: ThemeManager.primaryColor,

                            ),
                          ):
                          CustomElevatedButton(
                                 onPressed:
                              () async {
                                if (guestEmails.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please add at least one guest",
                                      ),
                                      backgroundColor: Colors.red,
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
