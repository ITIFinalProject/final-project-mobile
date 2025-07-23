import 'package:flutter/material.dart';

class ThemeManager{
  static const Color primaryColor = Color(0xff1B3C53);
  static const Color secondaryColor = Color(0xff456882);
  static const Color darkPinkColor = Color(0xffD2C1B6);
  static const Color lightPinkColor = Color(0xffF9F3EF);
  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: primaryColor
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        unselectedIconTheme: IconThemeData(
            color: darkPinkColor,
            size: 24
        ),
        selectedItemColor: lightPinkColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      )
  );
  static ThemeData darkTheme = ThemeData();
}