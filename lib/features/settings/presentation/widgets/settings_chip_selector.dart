import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:to_do/core/theme/app_colors.dart';

class SettingsChipSelector<T> extends StatelessWidget {
  const SettingsChipSelector({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });
  final List<SettingsChipItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: items.map((item) {
          final isSelected = item.value == selectedValue;

          return Expanded(
            key: ValueKey(item.value),
            child: Padding(
              padding: EdgeInsets.only(right: item != items.last ? 8 : 0),
              child: GestureDetector(
                onTap: () => onSelected(item.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: ShapeDecoration(
                    gradient: isSelected
                        ? AppColors.primaryGradient
                        : LinearGradient(
                            colors: [
                              if (isDark)
                                Colors.white.withValues(alpha: 0.05)
                              else
                                AppColors.inputBackgroundLight,
                              if (isDark)
                                Colors.white.withValues(alpha: 0.05)
                              else
                                AppColors.inputBackgroundLight,
                            ],
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryLight.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.icon != null) ...[
                        Icon(
                          item.icon,
                          size: 20,
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight),
                        ),
                        const Gap(4),
                      ],
                      Text(
                        item.label,
                        style: GoogleFonts.inter(
                          fontSize: 13,
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
    );
  }
}

class SettingsChipItem<T> {
  SettingsChipItem({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}
