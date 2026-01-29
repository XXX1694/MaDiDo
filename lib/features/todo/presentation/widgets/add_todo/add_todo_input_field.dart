import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';

class AddTodoInputField extends StatelessWidget {
  const AddTodoInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = false,
    this.textInputAction,
    required this.isDark,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w400,
  });
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int minLines;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final bool isDark;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : AppColors.inputBackgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(color: AppColors.borderDark.withValues(alpha: 0.3))
            : null,
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        minLines: minLines,
        textInputAction: textInputAction,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: isDark
              ? AppColors.textPrimaryDark
              : AppColors.textPrimaryLight,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: isDark
                ? AppColors.textSecondaryDark.withValues(alpha: 0.6)
                : AppColors.textSecondaryLight.withValues(alpha: 0.7),
            fontWeight: FontWeight.w400,
            fontSize: fontSize - 1,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
