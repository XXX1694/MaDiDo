import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/extensions/todo_extensions.dart';
import 'package:to_do/features/todo/presentation/widgets/todo_item/flow_checkbox.dart';
import 'package:to_do/features/todo/presentation/widgets/todo_item/todo_item_swipe_background.dart';
import 'package:to_do/features/todo/presentation/widgets/todo_item/todo_item_tag.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onPin,
    super.key,
  });
  final Todo todo;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onPin;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;

  bool? _isCompletedOverride;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );
    _sizeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleToggle() {
    final newValue = !(_isCompletedOverride ?? widget.todo.isCompleted);
    if (newValue) {
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.selectionClick();
    }

    setState(() {
      _isCompletedOverride = newValue;
    });

    widget.onToggle(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCompleted = _isCompletedOverride ?? widget.todo.isCompleted;
    final priorityColor = widget.todo.priorityColor;
    final category = widget.todo.category;

    return FadeTransition(
          opacity: _opacityAnimation,
          child: SizeTransition(
            sizeFactor: _sizeAnimation,
            axisAlignment: -1,
            child: Dismissible(
              key: Key(widget.todo.id),
              resizeDuration: const Duration(milliseconds: 200),
              background: const TodoItemSwipeBackground(isRightSwipe: false),
              secondaryBackground: const TodoItemSwipeBackground(
                isRightSwipe: true,
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  widget.onPin();
                  return false;
                }
                return true;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  widget.onDelete();
                }
              },
              child: Container(
                decoration: ShapeDecoration(
                  color: isDark
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: widget.todo.isPinned
                          ? priorityColor.withValues(alpha: 0.5)
                          : (isDark
                                ? AppColors.borderDark.withValues(alpha: 0.5)
                                : AppColors.borderLight),
                      width: widget.todo.isPinned ? 1.5 : 1,
                    ),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onTap: widget.onEdit,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlowCheckbox(
                            isChecked: isCompleted,
                            onTap: _handleToggle,
                            isDark: isDark,
                          ),
                          const Gap(16),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: isCompleted ? 0.5 : 1.0,
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
                                            decorationColor: isDark
                                                ? AppColors.textSecondaryDark
                                                : AppColors.textSecondaryLight,
                                            decorationThickness: 2,
                                            color: isDark
                                                ? AppColors.textPrimaryDark
                                                : AppColors.textPrimaryLight,
                                          ),
                                        ),
                                      ),
                                      if (widget.todo.isPinned) ...[
                                        const Gap(8),
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: priorityColor.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.push_pin_rounded,
                                            size: 16,
                                            color: isCompleted
                                                ? Colors.grey
                                                : priorityColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  if (widget.todo.description != null &&
                                      widget.todo.description!.isNotEmpty) ...[
                                    const Gap(8),
                                    Text(
                                      widget.todo.description!,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        height: 1.5,
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                        decoration: isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                        decorationColor: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                  const Gap(12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      TodoItemTag.priority(
                                        label: widget.todo.priorityLabel,
                                        color: priorityColor,
                                        icon: widget.todo.priorityIcon,
                                      ),
                                      if (category != null)
                                        TodoItemTag.category(
                                          name: category.name,
                                          color: Color(category.colorValue),
                                        ),
                                      if (widget.todo.deadline != null)
                                        TodoItemTag.deadline(
                                          deadline: widget.todo.deadline!,
                                          isOverdue: widget.todo.isOverdue,
                                          isCompleted: isCompleted,
                                          isDark: isDark,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
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
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }
}
