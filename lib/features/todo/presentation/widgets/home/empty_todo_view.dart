import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:to_do/core/theme/app_colors.dart';

class EmptyTodoView extends StatelessWidget {
  final bool filterCompleted;
  final String title;
  final String? subtitle;
  final bool isDark;

  const EmptyTodoView({
    super.key,
    required this.filterCompleted,
    required this.title,
    this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gradient Icon Container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryLight.withValues(alpha: 0.15),
                    AppColors.primaryDark.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Icon(
                  filterCompleted
                      ? Icons.task_alt_rounded
                      : Icons.checklist_rtl_rounded,
                  size: 56,
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(28),
            Text(
              title,
              style: GoogleFonts.inter(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const Gap(12),
              Text(
                subtitle!,
                style: GoogleFonts.inter(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
