import 'package:flutter/material.dart';

import '../strings/app_strings.dart';
import '../styles/app_styles.dart';

class AppThemes {
  final Color _appColor;

  AppThemes(this._appColor);

  ThemeData get lightTheme => _buildTheme(Brightness.light);

  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      fontFamily: AppStrings.fontRaleway,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: _appColor,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: AppStyles.paddingHorizontal,
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        border: OutlineInputBorder(
          borderRadius: AppStyles.mainBorderRadius,
          borderSide: BorderSide(
            width: 0.5,
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        dragHandleSize: Size(48, 3),
      ),
    );
  }
}