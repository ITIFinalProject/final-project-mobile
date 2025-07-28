import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);
typedef Changed =Function(String)?;

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int lines;
  final IconData? prefixIcon;
  final Validator? validator;
  final String hint;
  final VoidCallback? onTapped;
  final Changed? onChange;


  const CustomTextFormField({
    super.key,
    required this.validator,
    this.prefixIcon,
    required this.hint,
    required this.controller,
    this.onTapped,
    this.lines = 1,
    this.onChange

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        minLines: lines,
        maxLines: lines,
        onTap: onTapped,
        onChanged: onChange,

        decoration: CustomInputDecoration.getDecoration(
          hintText: hint,
          icon: prefixIcon,
        ),
        validator: validator,
      ),
    );
  }
}

class CustomInputDecoration {
  static InputDecoration getDecoration({
    required String hintText,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 15, color: ThemeManager.darkPinkColor),
      prefixIcon:
          icon != null
              ? Container(
                width: 35,
                height: 52,
                decoration: BoxDecoration(
                  color: ThemeManager.darkPinkColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(13),
                    topLeft: Radius.circular(13),
                  ),
                ),
        child: Icon(icon),
      )
          : null,
      enabled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeManager.primaryColor),
        borderRadius: BorderRadius.circular(13),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeManager.primaryColor),
        borderRadius: BorderRadius.circular(13),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(13),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(13),
      ),
    );
  }
}
