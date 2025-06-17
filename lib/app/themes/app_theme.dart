import 'package:flutter/material.dart';
import 'package:jobmaniaapp/app/constants/theme_constant.dart';

ThemeData getApplicationTheme() {
  const double largeFontSize = 40;
  const double mediumFontSize = 30;
  const double smallFontSize = 20;

  const FontWeight bold = FontWeight.w700;
  const FontWeight semiBold = FontWeight.w600;
  const FontWeight regular = FontWeight.w400;
  const FontWeight light = FontWeight.w300;

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 4,
      titleTextStyle: TextStyle(
        fontSize: largeFontSize,
        fontWeight: bold,
        color: AppColors.white,
        fontFamily: 'Montserrat',
      ),
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
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
