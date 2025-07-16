import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Color kNavyBlue = Color(0xFF004080); // أفتح من قبل
final Color kAppBarLight = Color(0xFF0066AA); // أفتح أكتر
final Color kGold = Color(0xFFF4C430);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kNavyBlue,
  scaffoldBackgroundColor: Color(0xFFF7F7F7),

  colorScheme: ColorScheme.light(
    primary: kNavyBlue,
    onPrimary: Colors.white,
    secondary: kGold,
    onSecondary: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Color(0xFFF8F9FA),
    onSurface: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 1,
    shadowColor: Colors.black12,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: kNavyBlue,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: kNavyBlue),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: kGold,
    unselectedItemColor: Colors.grey[600],
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  cardColor: Colors.white,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: kNavyBlue,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: kGold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kGold,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kNavyBlue,
  scaffoldBackgroundColor: Color(0xFF121212),
  colorScheme: ColorScheme.dark(
    primary: kNavyBlue,
    onPrimary: Colors.white,
    secondary: kGold,
    onSecondary: Colors.black,
    background: Color(0xFF121212),
    onBackground: Colors.white,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 1,
    shadowColor: Colors.black54,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: kGold,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: kGold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF121212),
      statusBarIconBrightness: Brightness.light,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: kGold,
    unselectedItemColor: Colors.grey[500],
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  cardColor: Color(0xFF1E1E1E),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: kGold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kGold,
      foregroundColor: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
