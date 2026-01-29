import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/core/theme/flow_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        onSurface: AppColors.textPrimaryLight,
        error: AppColors.error,
        outline: AppColors.borderLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: AppColors.textPrimaryLight,
        displayColor: AppColors.textPrimaryLight,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderLight, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: AppColors.textSecondaryLight, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return null;
        }),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        shadowColor: AppColors.primaryLight.withValues(alpha: 0.15),
        textStyle: GoogleFonts.inter(color: AppColors.textPrimaryLight),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textPrimaryLight,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[FlowColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
        outline: AppColors.borderDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.textPrimaryDark,
        displayColor: AppColors.textPrimaryDark,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: AppColors.textSecondaryDark, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryDark;
          }
          return null;
        }),
        checkColor: WidgetStateProperty.all(Colors.black),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.5),
        textStyle: GoogleFonts.inter(color: AppColors.textPrimaryDark),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textPrimaryDark,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[FlowColors.dark],
    );
  }
}
