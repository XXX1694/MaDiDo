import 'package:flutter/material.dart';

class AppColors {
  // Light Mode
  static const primaryLight = Color(0xFF005BEA); // Primary Blue
  static const backgroundLight = Color(
    0xFFF8FAFC,
  ); // Very light blue/gray background
  static const surfaceLight = Color(0xFFFFFFFF);
  static const textPrimaryLight = Color(0xFF1E293B); // Slate 800
  static const textSecondaryLight = Color(0xFF64748B); // Slate 500
  static const borderLight = Color(0xFFE2E8F0); // Slate 200
  static const inputBackgroundLight = Color(0xFFF5F7FA);

  // Dark Mode - Updated to match Flow vibe (optional but good practice)
  static const primaryDark = Color(0xFF00C6FB); // Lighter blue for dark mode
  static const backgroundDark = Color(0xFF0F172A); // Slate 900
  static const surfaceDark = Color(0xFF1E293B); // Slate 800
  static const textPrimaryDark = Color(0xFFF1F5F9); // Slate 100
  static const textSecondaryDark = Color(0xFF94A3B8); // Slate 400
  static const borderDark = Color(0xFF334155); // Slate 700

  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF005BEA), Color(0xFF00C6FB)],
  );

  static const error = Color(0xFFEF4444); // Red 500
  static const success = Color(0xFF22C55E); // Green 500
}
