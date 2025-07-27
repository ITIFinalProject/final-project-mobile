import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/profile/widgets/info_tile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  String? token;
  String? imagePath;




 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 100),
        child: Column(
          children: [
          

              // Profile Circle Avatar
              CircleAvatar(
                radius: 40,
              backgroundColor: ThemeManager.darkPinkColor,
              child: const Text(
                "DT",
                style: TextStyle(
                  fontSize: 24,
                  color: ThemeManager.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Name and Email
            Text(
              "Dylan Thomas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeManager.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "dylanthomas@server.com",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),
            
            InfoTile(title: "Edit Profile", icon: Icons.person, ontap: (){
                Navigator.pushNamed(context, AppRoutes.editProfile);
              }),
                InfoTile(title:  "Change Password",icon: Icons.lock,ontap: (){
                  Navigator.pushNamed(context,AppRoutes.verifyOldPassword);
                }),
            InfoTile(title: "Notification", icon: Icons.notifications, ontap: (){}),
            InfoTile(title: "Contact Us", icon: Icons.contact_page, ontap: (){}),
            InfoTile(title: "Sign Out", icon: Icons.logout, ontap: (){}),
           
      
          ],
        ),
      ),
    );
  }
}
