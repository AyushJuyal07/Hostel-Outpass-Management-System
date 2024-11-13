import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
  colorScheme:
      const ColorScheme.light(primary: Color.fromARGB(255, 150, 15, 12)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18))),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      color: Colors.black54,
    ),
    headlineMedium: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: Colors.black87,
      // fontWeight: FontWeight.w500,
      // fontSize: 18,
    ),
  ),
  dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
      contentTextStyle: TextStyle(
        color: Colors.black54,
      )),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    // focusColor: Colors.lightBlue,
  ),
);
