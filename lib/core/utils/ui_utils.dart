import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/core/theme/flow_colors.dart';

class UiUtils {
  static void showSnackBar(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool isError = false,
  }) {
    final colors = context.flowColors;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: colors.surface,
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: isError ? AppColors.error : colors.textPrimary,
          ),
        ),
        action: actionLabel != null && onActionPressed != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: AppColors.primaryLight,
                onPressed: onActionPressed,
              )
            : null,
      ),
    );
  }

  static void showFlowBottomSheet(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
  }) {
    final colors = context.flowColors;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: child,
      ),
    );
  }
}
