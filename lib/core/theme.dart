import 'package:flutter/material.dart';

class ThemeManager{
  static const Color primaryColor = Color(0xFF1B3C53);
  static const Color secondaryColor = Color(0xff456882);
  static const Color darkPinkColor = Color(0xffD2C1B6);
  static const Color lightPinkColor = Color(0xffF9F3EF);
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightPinkColor,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightPinkColor),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        color: lightPinkColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      unselectedIconTheme: IconThemeData(color: darkPinkColor, size: 24),
      selectedItemColor: lightPinkColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    inputDecorationTheme: InputDecorationTheme(

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(13),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color:primaryColor),
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
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeManager.primaryColor),
        borderRadius: BorderRadius.circular(13),
      ),
    )

  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: lightPinkColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor),

      iconTheme: IconThemeData(color: secondaryColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightPinkColor,
      unselectedIconTheme: IconThemeData(
        color: darkPinkColor,
        size: 24,
      ),
      selectedItemColor: lightPinkColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: secondaryColor.withOpacity(0.1),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightPinkColor),
          borderRadius: BorderRadius.circular(13),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:lightPinkColor , width: 2),
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
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeManager.lightPinkColor),
          borderRadius: BorderRadius.circular(13),
        ),
      ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: lightPinkColor),
      bodyMedium: TextStyle(color: lightPinkColor),
      bodySmall: TextStyle(color: darkPinkColor),
      titleLarge: TextStyle(color: lightPinkColor, fontWeight: FontWeight.bold),
    ),
    iconTheme: IconThemeData(color: lightPinkColor),
    // cardColor: secondaryColor,
  );
}