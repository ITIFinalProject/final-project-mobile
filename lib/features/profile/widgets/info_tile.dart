
import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  InfoTile({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
    this.subtitle,
  });

  final String title;
  final IconData icon;
  final dynamic ontap;
String ? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap
    ,
      child: ListTile(
        leading: Icon(icon, color: ThemeManager.primaryColor),
        title: Text(title, style: TextStyle(color: ThemeManager.primaryColor),),
        trailing: Icon(
          Icons.arrow_forward_ios, color: ThemeManager.primaryColor,),
          
      ),
    );
  }
}
