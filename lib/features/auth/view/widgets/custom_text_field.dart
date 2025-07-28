// custom textfield******
import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

typedef Validator = String? Function(String?);

class CustomTextFIeld extends StatelessWidget {
  String lable;
  Validator? validator;
  IconData icon;
  IconData? suffixIcon;
  VoidCallback? onPressedIcon;
  int lines;
  bool obscure;
  TextEditingController textFieldController;
  String? initialValue;
  bool enable;

  CustomTextFIeld({
    super.key,
    required this.lable,
    required this.icon,
    this.lines = 1,
    this.initialValue,
    this.obscure = false,
    this.enable = true,
    this.validator,
    this.suffixIcon,
    this.onPressedIcon,

    required this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: textFieldController,
        minLines: lines,
        initialValue: initialValue,
        maxLines: lines > 1 ? lines : 1,
        obscureText: obscure,
        enabled: enable,
        decoration: InputDecoration(
          prefix: Icon(icon, color: ThemeManager.secondaryColor),
          label: Text(lable),
          labelStyle: TextStyle(color: ThemeManager.primaryColor),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, color: ThemeManager.secondaryColor),
            onPressed: onPressedIcon,
          ),
          // labelStyle: TextStyle(color: color),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeManager.primaryColor),
            borderRadius: BorderRadius.circular(13),
          ),
          disabledBorder: OutlineInputBorder(
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
        ),
        validator:
            validator ??
            (value) {
              if (value!.isEmpty) {
                return "Please enter your $lable ....";
              }
              if (lable == "Email") {
                if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                  return "Please enter a valid email. ..";
                }
              }
              if (lable == "Password") {
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
              }
              if (lable == "Phone") {
                if (!RegExp(r"^01[0125]\d{8}").hasMatch(value)) {
                  return 'Please enter a valid phone like 01012345678.';
                }
              }

              return null;
            },
      ),
    );
  }
}
