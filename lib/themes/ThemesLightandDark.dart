import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color(0xFF002855), // Navy Blue
  colorScheme: ColorScheme.light(
    primary: Color(0xFF002855), // Navy Blue
    secondary: Color(0xFFF4C430), // Gold
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    background: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF002855),
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // BottomNavigationBar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFFF4C430), // Gold
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: Color(0xFFF4C430)),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFFF4C430),
    ),
    unselectedLabelStyle: TextStyle(color: Colors.grey),
    type: BottomNavigationBarType.fixed,
  ),

  // Text
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF002855), // Navy
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFFF4C430), // Gold accent
    ),
  ),

  // ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFF4C430), // Gold
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);


final darkTheme = ThemeData(
  primaryColor: Color(0xFF002855),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF002855),
    secondary: Color(0xFFF4C430),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    background: Color(0xFF121212),
    surface: Color(0xFF1F1F1F),
    onSurface: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1F1F1F),
    selectedItemColor: Color(0xFFF4C430), // الأصفر
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: Color(0xFFF4C430)),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF002855), // navy
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
