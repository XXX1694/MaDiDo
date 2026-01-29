import 'package:flutter/material.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/domain/entities/todo_category.dart';

extension TodoX on Todo {
  bool get isOverdue {
    if (deadline == null) return false;
    return deadline!.isBefore(DateTime.now()) && !isCompleted;
  }

  Color get priorityColor {
    switch (priority) {
      case TodoPriority.high:
        return AppColors.error;
      case TodoPriority.medium:
        return Colors.amber.shade600;
      case TodoPriority.low:
        return AppColors.success;
    }
  }

  String get priorityLabel {
    switch (priority) {
      case TodoPriority.high:
        return 'High';
      case TodoPriority.medium:
        return 'Medium';
      case TodoPriority.low:
        return 'Low';
    }
  }

  IconData get priorityIcon {
    switch (priority) {
      case TodoPriority.high:
        return Icons.keyboard_double_arrow_up_rounded;
      case TodoPriority.medium:
        return Icons.remove_rounded;
      case TodoPriority.low:
        return Icons.keyboard_double_arrow_down_rounded;
    }
  }

  TodoCategory? get category {
    if (categoryId == null) return null;
    try {
      return TodoCategory.defaultCategories.firstWhere(
        (c) => c.id == categoryId,
      );
    } catch (_) {
      return null;
    }
  }
}
