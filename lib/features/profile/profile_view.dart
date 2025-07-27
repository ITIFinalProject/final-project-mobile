
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:eventify_app/features/profile/widgets/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/alet_utils.dart';
import '../auth/cubit/auth_state.dart';


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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is AuthLoggedOut) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => true,
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
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

                InfoTile(
                  title: "Edit Profile",
                  icon: Icons.person,
                  ontap: () {
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  },
                ),
                InfoTile(
                  title: "Change Password",
                  icon: Icons.lock,
                  ontap: () {
                    Navigator.pushNamed(context, AppRoutes.verifyOldPassword);
                  },
                ),
                InfoTile(
                  title: "Notification",
                  icon: Icons.notifications,
                  ontap: () {},
                ),
                InfoTile(
                  title: "Contact Us",
                  icon: Icons.contact_page,
                  ontap: () {},
                ),
                if (state is AuthLoading)
                  Center(child: CircularProgressIndicator()),

                InfoTile(
                  title: "Sign Out",
                  icon: Icons.logout,
                  ontap: () {
                    Future.microtask(() => showAlertDialog());
                  },
                ),
              ],
            );
          }
        )
      ));
  }
  showAlertDialog() {
    showWarningQuickAlert(
      context: context,
      title: 'Sign Out',
      message: 'Are you sure you want to sign out?',
      onPressed: () {
        context.read<AuthCubit>().signOut();
      },
    );
  }

  //   return AwesomeDialog(
  //     context: context,
  //     animType: AnimType.rightSlide,
  //     dialogType: DialogType.info,
  //     title: 'Sign out',
  //     desc: 'Are you sure you want to sign out',
  //     btnOkOnPress: () {
  //       context.read<AuthCubit>().signOut();
  //     },
  //     btnCancelOnPress: (){
  //     }
  //   ).show();
  // }
  Widget _infoTile(String title, IconData icon, ontap) {
    return GestureDetector(
      onTap: ontap
      ,
      child: ListTile(
        leading: Icon(icon, color: ThemeManager.primaryColor),
        title: Text(title, style: TextStyle(color: ThemeManager.primaryColor),),
        trailing: Icon(
          Icons.arrow_forward_ios, color: ThemeManager.primaryColor,),
      ),
    );
  }
}
