import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/alet_utils.dart';
import '../../generated/l10n.dart';
import '../auth/cubit/auth_state.dart';
import 'cubit/language_cubit.dart';
import 'cubit/theme_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
            if (state is AuthFailure) {
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
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthSuccess) {
              final user = state.user;

              return Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: ThemeManager.darkPinkColor,
                    backgroundImage: user.imagePath != null
                        ? NetworkImage(user.imagePath!)
                        : null,
                    child: user.imagePath == null
                        ? Text(
                      user.name?.isNotEmpty == true ? user.name![0]
                          .toUpperCase() : '',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  _infoTile("Edit Profile", Icons.person, () {
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  }),
                  _infoTile("Change Password", Icons.lock, () {
                    Navigator.pushNamed(context, AppRoutes.verifyOldPassword);
                  }),
                  _infoTile("My Events", Icons.event_rounded, () {
                    Navigator.pushNamed(context, AppRoutes.myCreatedEvents);
                  }),
                  _infoTile("Notification", Icons.notifications, () {}),
                  _infoTile("Event Memories", Icons.memory, () {
                    Navigator.pushNamed(context, AppRoutes.eventMemories);
                  }),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      final isDark = themeMode == ThemeMode.dark;
                      return ListTile(
                        leading: Icon(
                          Icons.brightness_6,
                          color: ThemeManager.primaryColor,
                        ),
                        title: Text(
                          'Change Theme',
                          style: TextStyle(color: ThemeManager.primaryColor),
                        ),
                        trailing: Switch(
                          value: isDark,
                          onChanged: (_) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                          activeColor: ThemeManager.primaryColor,
                        ),
                      );
                    },
                  ),
                  BlocBuilder<LanguageCubit, Locale>(
                    builder: (context, locale) {
                      return ListTile(
                        leading: Icon(
                          Icons.language,
                          color: ThemeManager.primaryColor,
                        ),
                        title: Text(
                          S.of(context).change_language,
                          style: TextStyle(color: ThemeManager.primaryColor),
                        ),
                        trailing: DropdownButton<String>(
                          value: locale.languageCode,
                          items: const [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text('العربية'),
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              final cubit = context.read<LanguageCubit>();
                              if (val == 'en') {
                                cubit.setEnglish();
                              } else {
                                cubit.setArabic();
                              }
                            }
                          },
                          dropdownColor: Theme.of(context).cardColor,
                          style: TextStyle(color: ThemeManager.primaryColor),
                          underline: Container(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: ThemeManager.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),

                  _infoTile("Sign Out", Icons.logout, () {
                    Future.microtask(() => showAlertDialog());
                  }),
                ],
              );
            }

            return const Center(child: Text("No user data found."));
          },
        ),
      ),
    );
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
      onTap: ontap,
      child: ListTile(
        leading: Icon(icon, color: ThemeManager.primaryColor),
        title: Text(title, style: TextStyle(color: ThemeManager.primaryColor)),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ThemeManager.primaryColor,
        ),
      ),
    );
  }
}
