// custom textfield******
import 'package:flutter/material.dart';
typedef Validator = String? Function(String?);

class CustomTextFIeld extends StatelessWidget {
  String lable;
  Validator? validator;
  IconData icon;
  IconData? suffixIcon;
  VoidCallback? onPressedIcon;
  int lines;
  Color color;
  bool obscure;
  TextEditingController textFieldController;

  CustomTextFIeld({
    super.key,
    required this.lable,
    required this.icon,
    required this.lines,
    required this.color,
    this.obscure = false,
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
        // maxLines: 100,
        maxLines: lines > 1 ? lines : 1,
        obscureText: obscure,
        decoration: InputDecoration(
          prefix: Icon(icon, color: color),
          label: Text(lable),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, color: color),
            onPressed: onPressedIcon,
          ),
          // labelStyle: TextStyle(color: color),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(13),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(13),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(13),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
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
