import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/cubit/theme_cubit.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.normal,
            color: ThemeManager.primaryColor),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,

  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark?ThemeManager.lightPinkColor:ThemeManager.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color:isDark?ThemeManager.primaryColor:ThemeManager.lightPinkColor,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
