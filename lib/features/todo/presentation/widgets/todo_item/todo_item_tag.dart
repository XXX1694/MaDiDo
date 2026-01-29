import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/theme/app_colors.dart';

class TodoItemTag extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final bool isLineThrough;

  const TodoItemTag({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.isLineThrough = false,
  });

  factory TodoItemTag.priority({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return TodoItemTag(label: label, color: color, icon: icon);
  }

  factory TodoItemTag.category({required String name, required Color color}) {
    return TodoItemTag(label: name, color: color);
  }

  factory TodoItemTag.deadline({
    required DateTime deadline,
    required bool isOverdue,
    required bool isCompleted,
    required bool isDark,
  }) {
    final color = isOverdue
        ? AppColors.error
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    return TodoItemTag(
      label: DateFormat.MMMd().add_Hm().format(deadline),
      color: color,
      icon: Icons.schedule_rounded,
      isLineThrough: isCompleted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: ShapeDecoration(
        color: color.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              decoration: isLineThrough ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
