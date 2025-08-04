// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisableButton extends StatefulWidget {
  String label;
  DisableButton({Key? key, required this.label}) : super(key: key);

  @override
  State<DisableButton> createState() => _DisableButtonState();
}

class _DisableButtonState extends State<DisableButton> {
  @override
  Widget build(BuildContext context) {
    final thememode = context.watch<ThemeCubit>().state;
    final isDarkMode = thememode == ThemeMode.dark;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isDarkMode ? Colors.white.withOpacity(0.12) : Colors.grey[300]!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            isDarkMode ? ThemeManager.lightPinkColor : Colors.blueGrey,
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDarkMode ? ThemeManager.lightPinkColor : Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
