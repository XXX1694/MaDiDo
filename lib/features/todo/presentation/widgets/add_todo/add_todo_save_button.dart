import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';

class AddTodoSaveButton extends StatelessWidget {
  const AddTodoSaveButton({
    required this.label,
    required this.isEnabled,
    required this.onTap,
    required this.isDark,
    super.key,
  });
  final String label;
  final bool isEnabled;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: ShapeDecoration(
        gradient: isEnabled ? AppColors.primaryGradient : null,
        color: isEnabled
            ? null
            : (isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey[300]),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: isEnabled
                    ? Colors.white
                    : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
