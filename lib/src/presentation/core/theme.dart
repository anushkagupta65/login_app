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
    fontFamily: 'Lato',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextSecondary,
      ),
      headlineMedium: TextStyle(
        fontSize: 16.0,
        letterSpacing: -0.5,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextSecondary,
      ),
      headlineSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.lightTextSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.lightTextPrimary,
      ),
      titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
      ),
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
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          const TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
            fontSize: 14.0,
          ),
        ),
      ),
    ),
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
    fontFamily: 'Lato',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextSecondary,
      ),
      headlineSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.darkTextSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.darkTextPrimary,
      ),
      titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
      ),
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
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          const TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
            fontSize: 14.0,
          ),
        ),
      ),
    ),
  );
}
