import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color(0xFF6F3FCA),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF6F3FCA),
    secondary: Color(0xFFF4C430),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    background: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF6F3FCA),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF6F3FCA),
    ),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFF4C430),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF121212),
  primaryColor: Color(0xFF6F3FCA),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF6F3FCA),
    secondary: Color(0xFFF4C430),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    background: Color(0xFF121212),
    surface: Color(0xFF1F1F1F),
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF6F3FCA),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white70,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFF4C430),
      foregroundColor: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
