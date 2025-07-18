import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Color kBlack = Color(0xFF121212);
final Color kWhite = Colors.white;
final Color kGoldAccent = Color(0xFFFFC107);
final Color kLightGrey = Color(0xFFF5F5F5);
final Color kMediumGrey = Color(0xFF9E9E9E);
final Color kDarkGrey = Color(0xFF1E1E1E);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kBlack,
  scaffoldBackgroundColor: kWhite,
  cardColor: kWhite,
  colorScheme: ColorScheme.light(
    primary: kBlack,
    onPrimary: kWhite,
    secondary: kGoldAccent,
    onSecondary: kBlack,
    background: kWhite,
    onBackground: kBlack,
    surface: kLightGrey,
    onSurface: kBlack,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kWhite,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kBlack,
    ),
    iconTheme: IconThemeData(color: kBlack),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kWhite,
    selectedItemColor: kGoldAccent,
    unselectedItemColor: kMediumGrey,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: kBlack,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: kBlack,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: kGoldAccent,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kGoldAccent,
      foregroundColor: kBlack,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kWhite,
  scaffoldBackgroundColor: kBlack,
  cardColor: kDarkGrey,
  colorScheme: ColorScheme.dark(
    primary: kWhite,
    onPrimary: kBlack,
    secondary: kGoldAccent,
    onSecondary: kBlack,
    background: kBlack,
    onBackground: kWhite,
    surface: kDarkGrey,
    onSurface: kWhite,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkGrey,
    elevation: 0,
    shadowColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kGoldAccent,
    ),
    iconTheme: IconThemeData(color: kGoldAccent),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kDarkGrey,
    selectedItemColor: kGoldAccent,
    unselectedItemColor: Colors.grey[500],
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: kWhite,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: kWhite,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: kGoldAccent,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kGoldAccent,
      foregroundColor: kBlack,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
);
