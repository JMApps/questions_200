import 'package:flutter/material.dart';
import 'package:questions_200/application/styles/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.green,
    fontFamily: 'Nexa',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: AppStyles.mainShape,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.yellow,
    fontFamily: 'Nexa',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: AppStyles.mainShape,
    ),
  );
}

extension ColorSchemeS on ColorScheme {
  Color get titleColor => brightness == Brightness.light
      ? const Color(0xFF1B5E20)
      : const Color(0xFFFBC02D);
}
