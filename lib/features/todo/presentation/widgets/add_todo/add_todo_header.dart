import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';

class AddTodoHeader extends StatelessWidget {
  const AddTodoHeader({
    required this.title,
    required this.onClose,
    required this.isDark,
    super.key,
  });
  final String title;
  final VoidCallback onClose;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Drag Handle
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        // Header with gradient title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: onClose,
                icon: Icon(
                  Icons.close_rounded,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
