import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:to_do/core/theme/flow_colors.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({
    required this.onLoveIt,
    required this.onNeedsImprovement,
    required this.onLater,
    super.key,
  });

  final VoidCallback onLoveIt;
  final VoidCallback onNeedsImprovement;
  final VoidCallback onLater;

  @override
  Widget build(BuildContext context) {
    final colors = context.flowColors;
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colors.border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star_rounded, color: colors.primary, size: 40),
            ),
            const Gap(16),
            Text(
              l10n.reviewTitle,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              l10n.reviewDescription,
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            _ReviewButton(
              onTap: onLoveIt,
              text: l10n.reviewLoveIt,
              isPrimary: true,
            ),
            const Gap(8),
            _ReviewButton(
              onTap: onNeedsImprovement,
              text: l10n.reviewNeedsImprovement,
              isPrimary: false,
            ),
            const Gap(8),
            TextButton(
              onPressed: onLater,
              child: Text(
                l10n.reviewLater,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewButton extends StatelessWidget {
  const _ReviewButton({
    required this.onTap,
    required this.text,
    required this.isPrimary,
  });

  final VoidCallback onTap;
  final String text;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final colors = context.flowColors;

    return Material(
      color: isPrimary ? colors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: isPrimary
                ? null
                : Border.all(color: colors.border, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.white : colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
