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
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: lightPinkColor,
      ),
      iconTheme: IconThemeData(color: lightPinkColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      unselectedIconTheme: IconThemeData(
        color: darkPinkColor,
        size: 24,
      ),
      selectedItemColor: lightPinkColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: lightPinkColor),
      bodyMedium: TextStyle(color: lightPinkColor),
      bodySmall: TextStyle(color: darkPinkColor),
      titleLarge: TextStyle(color: lightPinkColor, fontWeight: FontWeight.bold),
    ),
    iconTheme: IconThemeData(color: lightPinkColor),
    cardColor: secondaryColor,
  );
}