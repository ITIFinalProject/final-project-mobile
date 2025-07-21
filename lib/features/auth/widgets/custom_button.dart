// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onPressed;
 
  Color buttonColor;
  
  double hPadding;
  double vPadding;
  Widget buttonChild;
  CustomButton({
    super.key,
    required this.onPressed,
   
    required this.buttonColor,
   
    required this.hPadding,
    required this.vPadding,
    required this.buttonChild,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
      ),
      child: buttonChild
    );
  }
}

class buttonText extends StatelessWidget {
  String text;
   buttonText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(text,style: TextStyle(color:Colors.white, fontSize: 20),);
  }
}
