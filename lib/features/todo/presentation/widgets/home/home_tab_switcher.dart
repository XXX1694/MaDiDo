import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';

class HomeTabSwitcher extends StatelessWidget {
  const HomeTabSwitcher({
    required this.currentIndex,
    required this.onTabChanged,
    required this.leftLabel,
    required this.rightLabel,
    required this.isDark,
    super.key,
  });
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final String leftLabel;
  final String rightLabel;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryLight.withValues(
                alpha: isDark ? 0.05 : 0.08,
              ),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Sliding Background
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutExpo,
              alignment: Alignment(currentIndex == 0 ? -1 : 1, 0),
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryLight.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Tab Buttons
            Row(
              children: [
                _HomeTabButton(
                  label: leftLabel,
                  isActive: currentIndex == 0,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onTabChanged(0);
                  },
                  isDark: isDark,
                ),
                _HomeTabButton(
                  label: rightLabel,
                  isActive: currentIndex == 1,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onTabChanged(1);
                  },
                  isDark: isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              color: isActive
                  ? Colors.white
                  : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
