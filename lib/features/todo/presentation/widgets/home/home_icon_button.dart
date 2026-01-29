import 'package:flutter/material.dart';
import 'package:to_do/core/theme/flow_colors.dart';

/// Reusable icon button component for home header
/// Provides consistent styling with optional active state indicator
class HomeIconButton extends StatelessWidget {
  const HomeIconButton({
    required this.icon,
    required this.onTap,
    this.isActive = false,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.flowColors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isActive
                ? colors.primary.withValues(
                    alpha: Theme.of(context).brightness == Brightness.dark
                        ? 0.15
                        : 0.05,
                  )
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? colors.primary : colors.textPrimary,
                size: 26,
              ),
              if (isActive)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
