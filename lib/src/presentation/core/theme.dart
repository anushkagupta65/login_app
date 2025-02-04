import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/src/presentation/core/app_colors.dart';

class AppTheme {
  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  /// Light style
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    highlightColor: AppColors.lightHighlight,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.lightTextSecondary,
      backgroundColor: AppColors.lightBackground,
    ),
    disabledColor: AppColors.lightDivider,
    primaryColor: AppColors.primary,
    iconTheme: const IconThemeData(color: AppColors.lightTextSecondary),
    pageTransitionsTheme: _pageTransitionsTheme,
    fontFamily: 'Triodion',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),
    dividerColor: AppColors.lightDivider,
  );

  /// Dark style
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    highlightColor: AppColors.darkHighlight,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.light),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.darkTextSecondary,
      backgroundColor: AppColors.darkBackground,
    ),
    disabledColor: AppColors.darkDivider,
    primaryColor: AppColors.primary,
    iconTheme: const IconThemeData(color: AppColors.darkTextSecondary),
    pageTransitionsTheme: _pageTransitionsTheme,
    fontFamily: 'Triodion',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),
    dividerColor: AppColors.darkDivider,
  );
}
