import 'package:flutter/material.dart';
import 'package:to_do/core/theme/app_colors.dart';

class FlowCheckbox extends StatelessWidget {
  const FlowCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
    required this.isDark,
  });
  final bool isChecked;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedScale(
          scale: isChecked ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 26,
            height: 26,
            decoration: ShapeDecoration(
              gradient: isChecked ? AppColors.primaryGradient : null,
              color: isChecked ? null : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: isChecked
                    ? BorderSide.none
                    : BorderSide(
                        color: isDark
                            ? AppColors.textSecondaryDark.withValues(alpha: 0.3)
                            : AppColors.textSecondaryLight.withValues(
                                alpha: 0.2,
                              ),
                        width: 2,
                      ),
              ),
              shadows: isChecked
                  ? [
                      BoxShadow(
                        color: AppColors.primaryLight.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: isChecked ? 1.0 : 0.0,
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
