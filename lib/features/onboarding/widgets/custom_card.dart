import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String text;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shadowColor: ThemeManager.lightPinkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: ThemeManager.secondaryColor, width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: size.width * 0.8,
              height: size.height * 0.6,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: isDark?ThemeManager.lightPinkColor: ThemeManager.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            shadows: [BoxShadow(color: Colors.redAccent[100]!, blurRadius: 50)],
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: isDark? ThemeManager.lightPinkColor:ThemeManager.primaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
