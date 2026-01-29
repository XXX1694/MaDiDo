import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

class PriorityFilterSection extends StatelessWidget {
  final TodoPriority? selectedPriority;
  final ValueChanged<TodoPriority?> onPrioritySelected;
  final String label;
  final bool isDark;

  const PriorityFilterSection({
    super.key,
    required this.selectedPriority,
    required this.onPrioritySelected,
    required this.label,
    required this.isDark,
  });

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
        Row(
          children: TodoPriority.values.map((priority) {
            final isSelected = selectedPriority == priority;
            Color color;
            String priorityLabel;
            IconData icon;
            switch (priority) {
              case TodoPriority.high:
                color = AppColors.error;
                priorityLabel = 'High';
                icon = Icons.keyboard_double_arrow_up_rounded;
              case TodoPriority.medium:
                color = Colors.amber.shade600;
                priorityLabel = 'Medium';
                icon = Icons.remove_rounded;
              case TodoPriority.low:
                color = AppColors.success;
                priorityLabel = 'Low';
                icon = Icons.keyboard_double_arrow_down_rounded;
            }
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: priority != TodoPriority.values.last ? 8 : 0,
                ),
                child: GestureDetector(
                  onSecondaryTap: () => onPrioritySelected(null),
                  onTap: () => onPrioritySelected(isSelected ? null : priority),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutExpo,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      color: isSelected
                          ? color
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : AppColors.inputBackgroundLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 18,
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight),
                        ),
                        const Gap(4),
                        Text(
                          priorityLabel,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
