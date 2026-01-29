import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/theme/app_colors.dart';

class AddTodoDeadlinePicker extends StatelessWidget {
  const AddTodoDeadlinePicker({
    required this.deadline,
    required this.onTap,
    required this.onClear,
    required this.isDark,
    required this.label,
    required this.hintText,
    super.key,
  });
  final DateTime? deadline;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final bool isDark;
  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: -0.3,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const Gap(12),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: deadline != null
                  ? LinearGradient(
                      colors: [
                        AppColors.primaryLight.withValues(alpha: 0.08),
                        AppColors.primaryDark.withValues(alpha: 0.04),
                      ],
                    )
                  : null,
              color: deadline == null
                  ? (isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : AppColors.inputBackgroundLight)
                  : null,
              borderRadius: BorderRadius.circular(12),
              border: deadline != null
                  ? Border.all(
                      color: AppColors.primaryLight.withValues(alpha: 0.3),
                      width: 1.5,
                    )
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: deadline != null
                        ? AppColors.primaryGradient
                        : null,
                    color: deadline == null
                        ? (isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.05))
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                    color: deadline != null
                        ? Colors.white
                        : (isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight),
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Text(
                    deadline != null
                        ? DateFormat.yMMMd().add_Hm().format(deadline!)
                        : hintText,
                    style: GoogleFonts.inter(
                      color: deadline != null
                          ? (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.primaryLight)
                          : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (deadline != null)
                  GestureDetector(
                    onTap: onClear,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: isDark
                            ? AppColors.primaryDark
                            : AppColors.primaryLight,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
