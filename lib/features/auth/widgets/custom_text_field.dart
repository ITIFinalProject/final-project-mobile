// custom textfield******
import 'package:flutter/material.dart';

class CustomTextFIeld extends StatelessWidget {
  String lable;
  IconData icon;
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
    required this.obscure,
    required this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      minLines: lines,
      // maxLines: 100,
      maxLines: lines > 1 ? lines : 1,
      obscureText: obscure,
      decoration: InputDecoration(
        prefix: Icon(icon, color: color),
        label: Text(lable),

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
      ),
      validator: (value) {
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

        return null;
      },
    );
  }
}
