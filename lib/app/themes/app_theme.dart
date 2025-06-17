import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  const double largeFontSize = 40;
  const double mediumFontSize = 30;
  const double smallFontSize = 20;

  const FontWeight bold = FontWeight.w700;
  const FontWeight semiBold = FontWeight.w600;
  const FontWeight regular = FontWeight.w400;
  const FontWeight light = FontWeight.w300;

  const Color primaryColor = Color(0xFF356899);

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 4,
      titleTextStyle: TextStyle(
        fontSize: largeFontSize,
        fontWeight: bold,
        color: Colors.white,
        fontFamily: 'Montserrat',
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      // Large Headings (AppBar titles, screen titles)
      displayLarge: TextStyle(
        fontSize: largeFontSize,
        fontWeight: bold,
        fontFamily: 'Montserrat',
      ),
      headlineLarge: TextStyle(
        fontSize: largeFontSize,
        fontWeight: semiBold,
        fontFamily: 'Montserrat',
      ),
      titleLarge: TextStyle(
        fontSize: largeFontSize,
        fontWeight: bold,
        fontFamily: 'Montserrat',
      ),

      // Medium text (e.g., job cards, company names)
      displayMedium: TextStyle(
        fontSize: mediumFontSize,
        fontWeight: regular,
        fontFamily: 'Nunito Sans',
      ),
      headlineMedium: TextStyle(
        fontSize: mediumFontSize,
        fontWeight: regular,
        fontFamily: 'Nunito Sans',
      ),
      titleMedium: TextStyle(
        fontSize: mediumFontSize,
        fontWeight: regular,
        fontFamily: 'Nunito Sans',
      ),
      bodyMedium: TextStyle(
        fontSize: mediumFontSize,
        fontWeight: regular,
        fontFamily: 'Nunito Sans',
      ),
      labelMedium: TextStyle(
        fontSize: mediumFontSize,
        fontWeight: semiBold,
        fontFamily: 'Nunito Sans',
      ),

      // Small text (e.g., location, salary, job type tags)
      displaySmall: TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: 'Open Sans',
      ),
      headlineSmall: TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: 'Open Sans',
      ),
      titleSmall: TextStyle(
        fontSize: smallFontSize,
        fontWeight: regular,
        fontFamily: 'Open Sans',
      ),
      bodySmall: TextStyle(
        fontSize: smallFontSize,
        fontWeight: regular,
        fontFamily: 'Open Sans',
      ),
      labelSmall: TextStyle(
        fontSize: smallFontSize,
        fontWeight: semiBold,
        fontFamily: 'Open Sans',
      ),
    ),
  );
}
