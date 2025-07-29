import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/alet_utils.dart';
import '../auth/cubit/auth_state.dart';

import '../../generated/l10n.dart';
import 'cubit/language_cubit.dart';
import 'cubit/theme_cubit.dart';

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
                _infoTile("Contact Us", Icons.contact_page, () {}),
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
                          DropdownMenuItem(value: 'en', child: Text('English')),
                          DropdownMenuItem(value: 'ar', child: Text('العربية')),
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

                if (state is AuthLoading)
                  Center(child: CircularProgressIndicator()),

                _infoTile("Sign Out", Icons.logout, () {
                  Future.microtask(() => showAlertDialog());
                }),
              ],
            );
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
