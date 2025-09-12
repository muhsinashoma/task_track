import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.white,
      // Keep icons using default font
      iconTheme: const IconThemeData(
        color: Colors.red,
        size: 24,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        displayMedium: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        displaySmall: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        headlineSmall: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        titleLarge: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        bodyLarge: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        bodyMedium: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        titleMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
        titleSmall: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat'),
      ),
      primaryTextTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          minimumSize: const Size(150, 50),
          maximumSize: const Size(300, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          minimumSize: const Size(double.infinity, 50),
          disabledForegroundColor: Colors.black38.withOpacity(0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: Colors.red),
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          textStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.red,
        secondary: Colors.blue,
        background: Colors.white,
      ),
    );
  }
}
