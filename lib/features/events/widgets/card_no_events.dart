import 'package:flutter/material.dart';

import '../../../core/theme.dart';

class CardNoEvents extends StatelessWidget{
  final String text ;
  final String title;
  const CardNoEvents({super.key , required this.text , required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: ThemeManager.lightPinkColor,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: ThemeManager.secondaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Icon(Icons.event_busy, size: 50, color: Color(0xFF1B3C53)),
              SizedBox(height: 12),
              Text(
              title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1B3C53),
                ),
              ),
              SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF456882)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
