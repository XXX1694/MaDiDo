import 'package:flutter/material.dart';
import 'package:to_do/core/theme/app_colors.dart';

class TodoItemSwipeBackground extends StatelessWidget {
  // true for Delete (right to left), false for Pin (left to right)

  const TodoItemSwipeBackground({super.key, required this.isRightSwipe});
  final bool isRightSwipe;

  @override
  Widget build(BuildContext context) {
    if (isRightSwipe) {
      // Delete background
      return Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.error.withValues(alpha: 0.05),
              AppColors.error.withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.delete_rounded,
            color: AppColors.error,
            size: 24,
          ),
        ),
      );
    } else {
      // Pin background
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent.withValues(alpha: 0.2),
              Colors.orangeAccent.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orangeAccent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.push_pin_rounded,
            color: Colors.orangeAccent,
            size: 24,
          ),
        ),
      );
    }
  }
}
