import 'package:flutter/material.dart';
import 'package:to_do/core/theme/app_colors.dart';

/// Theme extension for Flow design system colors
/// Eliminates the need for isDark ternary operators in build methods
@immutable
class FlowColors extends ThemeExtension<FlowColors> {
  const FlowColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.inputBackground,
  });

  final Color primary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color inputBackground;

  // Light theme colors
  static const light = FlowColors(
    primary: AppColors.primaryLight,
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
    border: AppColors.borderLight,
    inputBackground: AppColors.inputBackgroundLight,
  );

  // Dark theme colors
  static const dark = FlowColors(
    primary: AppColors.primaryDark,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    border: AppColors.borderDark,
    inputBackground: AppColors.surfaceDark,
  );

  @override
  FlowColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? inputBackground,
  }) {
    return FlowColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      inputBackground: inputBackground ?? this.inputBackground,
    );
  }

  @override
  FlowColors lerp(ThemeExtension<FlowColors>? other, double t) {
    if (other is! FlowColors) {
      return this;
    }
    return FlowColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
    );
  }
}

/// Extension to get FlowColors from BuildContext
extension FlowColorsExtension on BuildContext {
  FlowColors get flowColors =>
      Theme.of(this).extension<FlowColors>() ?? FlowColors.light;
}
