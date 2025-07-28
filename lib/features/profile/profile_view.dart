import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/core/theme_cubit.dart';
import 'package:eventify_app/core/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
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
            _infoTile("Edit Profile", Icons.person, () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            }),

            _infoTile("Notification", Icons.notifications, () {}),
            _infoTile("Contact Us", Icons.contact_page, () {}),

            // Theme Switcher
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.brightness_6,
                        color: ThemeManager.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'change theme',
                        style: TextStyle(
                          color: ThemeManager.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      final isDark =
                          Theme.of(context).brightness == Brightness.dark;
                      return Switch(
                        value: isDark,
                        onChanged: (_) {
                          final cubit = context.read<ThemeCubit>();
                          cubit.toggleTheme();
                        },
                        activeColor: ThemeManager.primaryColor,
                      );
                    },
                  ),
                ],
              ),
            ),

            // Language Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: ThemeManager.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'تغيير اللغة',
                        style: TextStyle(
                          color: ThemeManager.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      final locale =
                          Localizations.localeOf(context).languageCode;
                      return DropdownButton<String>(
                        value: locale,
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
                        style: TextStyle(
                          color: ThemeManager.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: ThemeManager.primaryColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            _infoTile("Sign Out", Icons.logout, () {}),
          ],
        ),
      ),
    );
  }

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
