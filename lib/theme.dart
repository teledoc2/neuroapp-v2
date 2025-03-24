
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF32373C),
  primarySwatch: MaterialColor(
    0xFF32373C,
    {
      50: Color(0xFFE3E4E5),
      100: Color(0xFFB8BABC),
      200: Color(0xFF8A8D90),
      300: Color(0xFF5C5F63),
      400: Color(0xFF3C4044),
      500: Color(0xFF32373C),
      600: Color(0xFF2C3135),
      700: Color(0xFF24282C),
      800: Color(0xFF1C2023),
      900: Color(0xFF121416),
    },
  ),
  accentColor: Color(0xFFF78DA7),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  backgroundColor: Color(0xFFFFFFFF),
  fontFamily: 'Roboto, Arial, sans-serif',
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF32373C),
    foregroundColor: Color(0xFFFFFFFF),
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFFFFFFFF),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.bold,
      color: Color(0xFF000000),
    ),
    headlineMedium: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Color(0xFF000000),
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF000000),
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFF000000),
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: Color(0xFFABB8C3),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color(0xFFABB8C3),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF32373C),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9999),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 18,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Color(0xFF32373C),
      primary: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 18,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF32373C),
      onPrimary: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 18,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Color(0xFF32373C),
      side: BorderSide(color: Color(0xFF32373C)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 18,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFFABB8C3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF32373C)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFFCF2E2E)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFFCF2E2E)),
    ),
    labelStyle: TextStyle(
      color: Color(0xFFABB8C3),
      fontSize: 13,
    ),
    hintStyle: TextStyle(
      color: Color(0xFFABB8C3),
      fontSize: 13,
    ),
  ),
  cardTheme: CardTheme(
    color: Color(0xFFFFFFFF),
    shadowColor: Color(0xFF000000).withOpacity(0.2),
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    margin: EdgeInsets.all(8),
  ),
);
