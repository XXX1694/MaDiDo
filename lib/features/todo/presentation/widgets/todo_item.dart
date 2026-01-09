import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/domain/entities/todo_category.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onPin;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onPin,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;
  bool? _isCompletedOverride;

  bool get _isOverdue {
    if (widget.todo.deadline == null) return false;
    return widget.todo.deadline!.isBefore(DateTime.now()) &&
        !widget.todo.isCompleted;
  }

  Color _getPriorityColor(TodoPriority p) {
    switch (p) {
      case TodoPriority.high:
        return AppColors.error;
      case TodoPriority.medium:
        return Colors.orange;
      case TodoPriority.low:
        return Colors.blue;
    }
  }

  TodoCategory? get _category {
    if (widget.todo.categoryId == null) return null;
    try {
      return TodoCategory.defaultCategories.firstWhere(
        (c) => c.id == widget.todo.categoryId,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleToggle(bool value) {
    if (value) {
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.selectionClick();
    }

    setState(() {
      _isCompletedOverride = value;
    });

    _controller.forward().then((_) {
      widget.onToggle(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isCompleted = _isCompletedOverride ?? widget.todo.isCompleted;
    final priorityColor = _getPriorityColor(widget.todo.priority);
    final category = _category;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: SizeTransition(
        sizeFactor: _sizeAnimation,
        axisAlignment: -1.0,
        child: Dismissible(
          key: Key(widget.todo.id),
          direction: DismissDirection.horizontal,
          resizeDuration: const Duration(milliseconds: 200),
          // Allow swipe left to delete, swipe right to pin
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            color: Colors.orangeAccent,
            child: Icon(
              widget.todo.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: AppColors.error,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              widget.onPin();
              return false; // Don't delete
            }
            return true; // Delete
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              widget.onDelete();
            }
          },
          child: Card(
            elevation: widget.todo.isPinned ? 4 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: widget.todo.isPinned
                  ? BorderSide(
                      color: priorityColor.withValues(alpha: 0.5),
                      width: 1.5,
                    )
                  : BorderSide.none,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.onEdit,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // Left border for priority
                  gradient: LinearGradient(
                    stops: const [0.02, 0.02],
                    colors: [priorityColor, Colors.transparent],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: isCompleted,
                          onChanged: (v) => _handleToggle(v ?? false),
                          shape: const CircleBorder(),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.todo.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      decoration: isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: isCompleted
                                          ? (isDark
                                                ? AppColors.textSecondaryDark
                                                : AppColors.textSecondaryLight)
                                          : (isDark
                                                ? AppColors.textPrimaryDark
                                                : AppColors.textPrimaryLight),
                                    ),
                                  ),
                                ),
                                if (widget.todo.isPinned)
                                  Icon(
                                    Icons.push_pin,
                                    size: 16,
                                    color: priorityColor,
                                  ),
                              ],
                            ),
                            if (widget.todo.description != null &&
                                widget.todo.description!.isNotEmpty) ...[
                              const Gap(4),
                              Text(
                                widget.todo.description!,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            const Gap(6),
                            Row(
                              children: [
                                if (category != null) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(
                                        category.colorValue,
                                      ).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        color: Color(category.colorValue),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Gap(8),
                                ],
                                if (widget.todo.deadline != null) ...[
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 14,
                                    color: _isOverdue
                                        ? AppColors.error
                                        : (isDark
                                              ? AppColors.textSecondaryDark
                                              : AppColors.textSecondaryLight),
                                  ),
                                  const Gap(4),
                                  Text(
                                    DateFormat.yMMMd().add_Hm().format(
                                      widget.todo.deadline!,
                                    ),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: _isOverdue
                                          ? AppColors.error
                                          : (isDark
                                                ? AppColors.textSecondaryDark
                                                : AppColors.textSecondaryLight),
                                      decoration: isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                  if (_isOverdue) ...[
                                    const Gap(4),
                                    Text(
                                      '!',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.error,
                                      ),
                                    ),
                                  ],
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
  }
}
