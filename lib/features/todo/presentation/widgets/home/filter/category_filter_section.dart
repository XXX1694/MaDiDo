import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/todo_category.dart';

class CategoryFilterSection extends StatelessWidget {
  const CategoryFilterSection({
    required this.selectedCategoryId,
    required this.onCategorySelected,
    required this.label,
    required this.isDark,
    super.key,
  });
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;
  final String label;
  final bool isDark;

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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: TodoCategory.defaultCategories.map((category) {
              final isSelected = selectedCategoryId == category.id;
              final color = Color(category.colorValue);
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () =>
                      onCategorySelected(isSelected ? null : category.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: ShapeDecoration(
                      color: isSelected
                          ? color
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : AppColors.inputBackgroundLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      shadows: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      category.name,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
