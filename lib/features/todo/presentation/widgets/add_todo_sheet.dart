import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/domain/entities/todo_category.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddTodoSheet extends StatefulWidget {
  const AddTodoSheet({super.key, this.todo});

  final Todo? todo;

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _deadline;
  TodoPriority _priority = TodoPriority.medium;
  String? _categoryId;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description ?? '';
      _deadline = widget.todo!.deadline;
      _priority = widget.todo!.priority;
      _categoryId = widget.todo!.categoryId;
      _isButtonEnabled = true;
    }
    _titleController.addListener(_validate);
  }

  void _validate() {
    setState(() {
      _isButtonEnabled = _titleController.text.trim().isNotEmpty;
    });
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final initialDate = _deadline ?? now;

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    if (!mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        _deadline ?? now.add(const Duration(hours: 1)),
      ),
    );

    if (time == null) return;

    setState(() {
      _deadline = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _onSave() {
    HapticFeedback.mediumImpact();
    if (!_isButtonEnabled) return;

    if (widget.todo != null) {
      final updatedTodo = widget.todo!.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        deadline: _deadline,
        priority: _priority,
        categoryId: _categoryId,
      );
      context.read<TodoBloc>().add(TodoUpdated(updatedTodo));
    } else {
      final todo = Todo(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        createdAt: DateTime.now(),
        deadline: _deadline,
        priority: _priority,
        categoryId: _categoryId,
      );

      context.read<TodoBloc>().add(TodoAdded(todo));
    }
    context.pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.todo != null ? l10n.editTask : l10n.newTask,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Gap(16),
          TextField(
            controller: _titleController,
            autofocus: true,
            maxLines: 5,
            minLines: 1,
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: l10n.whatNeedsToBeDone,
              hintStyle: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const Gap(12),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            minLines: 1,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: l10n.descriptionOptional,
              hintStyle: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark.withValues(alpha: 0.7)
                    : AppColors.textSecondaryLight.withValues(alpha: 0.7),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const Gap(16),
          Row(
            children: [
              TextButton.icon(
                onPressed: _pickDeadline,
                icon: Icon(
                  Icons.calendar_today_rounded,
                  size: 20,
                  color: _deadline != null
                      ? (isDark
                            ? AppColors.primaryDark
                            : AppColors.primaryLight)
                      : Colors.grey,
                ),
                label: Text(
                  _deadline != null
                      ? DateFormat.yMMMd().add_Hm().format(_deadline!)
                      : l10n.addDeadline,
                  style: GoogleFonts.inter(
                    color: _deadline != null
                        ? (isDark
                              ? AppColors.primaryDark
                              : AppColors.primaryLight)
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  backgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (_deadline != null)
                IconButton(
                  onPressed: () => setState(() => _deadline = null),
                  icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                ),
            ],
          ),
          const Gap(16),
          Text(
            'Priority',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            children: TodoPriority.values.map((priority) {
              final isSelected = _priority == priority;
              Color color;
              if (priority == TodoPriority.high) {
                color = Colors.redAccent;
              } else if (priority == TodoPriority.medium) {
                color = Colors.orangeAccent;
              } else {
                color = Colors.blueAccent;
              }

              return ChoiceChip(
                showCheckmark: false,
                label: Text(
                  priority.name.toUpperCase(),
                  style: const TextStyle(fontSize: 12),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) setState(() => _priority = priority);
                },
                selectedColor: color.withValues(alpha: 0.2),
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                labelStyle: TextStyle(
                  color: isSelected
                      ? color
                      : (isDark ? Colors.white60 : Colors.black54),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                side: isSelected ? BorderSide(color: color) : BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }).toList(),
          ),
          const Gap(16),
          Text(
            'Category',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const Gap(8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...TodoCategory.defaultCategories.map((category) {
                  final isSelected = _categoryId == category.id;
                  final color = Color(category.colorValue);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      showCheckmark: false,
                      label: Text(
                        category.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _categoryId = selected ? category.id : null;
                        });
                      },
                      selectedColor: color.withValues(alpha: 0.2),
                      backgroundColor: isDark
                          ? Colors.grey[800]
                          : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected
                            ? color
                            : (isDark ? Colors.white60 : Colors.black54),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      side: isSelected
                          ? BorderSide(color: color)
                          : BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      avatar: CircleAvatar(backgroundColor: color, radius: 4),
                    ),
                  );
                }),
              ],
            ),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _isButtonEnabled ? _onSave : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                  foregroundColor: isDark
                      ? Colors
                            .black // Text on white button
                      : Colors.white, // Text on black button
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.todo != null ? l10n.saveChanges : l10n.createTask,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
