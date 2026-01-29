import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/utils/date_time_utils.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/domain/factories/todo_factory.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo/add_todo_category_picker.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo/add_todo_deadline_picker.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo/add_todo_header.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo/add_todo_input_field.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo/add_todo_priority_picker.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo/add_todo_save_button.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

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

  void _validate() => setState(
    () => _isButtonEnabled = _titleController.text.trim().isNotEmpty,
  );

  Future<void> _pickDeadline() async {
    final picked = await DateTimeUtils.pickDateTime(
      context,
      initialDate: _deadline,
    );
    if (picked != null) {
      setState(() => _deadline = picked);
    }
  }

  void _onSave() {
    HapticFeedback.mediumImpact();
    if (!_isButtonEnabled) return;
    if (widget.todo != null) {
      context.read<TodoBloc>().add(
        TodoUpdated(
          TodoFactory.update(
            original: widget.todo!,
            title: _titleController.text,
            description: _descriptionController.text,
            deadline: _deadline,
            priority: _priority,
            categoryId: _categoryId,
          ),
        ),
      );
    } else {
      context.read<TodoBloc>().add(
        TodoAdded(
          TodoFactory.create(
            title: _titleController.text,
            description: _descriptionController.text,
            deadline: _deadline,
            priority: _priority,
            categoryId: _categoryId,
          ),
        ),
      );
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
        left: 24,
        right: 24,
        top: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddTodoHeader(
            title: widget.todo != null ? l10n.editTask : l10n.newTask,
            onClose: () => context.pop(),
            isDark: isDark,
          ),
          const Gap(28),
          AddTodoInputField(
            controller: _titleController,
            hintText: l10n.whatNeedsToBeDone,
            autofocus: true,
            maxLines: 3,
            textInputAction: TextInputAction.next,
            isDark: isDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const Gap(16),
          AddTodoInputField(
            controller: _descriptionController,
            hintText: l10n.descriptionOptional,
            maxLines: 4,
            minLines: 2,
            isDark: isDark,
          ),
          const Gap(24),
          AddTodoDeadlinePicker(
            deadline: _deadline,
            onTap: _pickDeadline,
            onClear: () => setState(() => _deadline = null),
            isDark: isDark,
            label: l10n.deadline,
            hintText: l10n.addDeadline,
          ),
          const Gap(24),
          AddTodoPriorityPicker(
            selectedPriority: _priority,
            onSelected: (p) => setState(() => _priority = p),
            isDark: isDark,
            label: l10n.priority,
          ),
          const Gap(24),
          AddTodoCategoryPicker(
            selectedCategoryId: _categoryId,
            onSelected: (id) => setState(() => _categoryId = id),
            isDark: isDark,
            label: l10n.category,
          ),
          const Gap(32),
          AddTodoSaveButton(
            label: widget.todo != null ? l10n.saveChanges : l10n.createTask,
            isEnabled: _isButtonEnabled,
            onTap: _onSave,
            isDark: isDark,
          ),
          const Gap(24),
        ],
      ),
    );
  }
}
