import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/core/utils/ui_utils.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo_sheet.dart';
import 'package:to_do/features/todo/presentation/widgets/home/empty_todo_view.dart';
import 'package:to_do/features/todo/presentation/widgets/todo_item.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({required this.filterCompleted, super.key});
  final bool filterCompleted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        if (state.status == TodoStatus.loading) {
          return const _LoadingView();
        }

        final todos =
            (filterCompleted ? state.completedTodos : state.pendingTodos)
                .toList();

        if (todos.isEmpty) {
          return EmptyTodoView(
            filterCompleted: filterCompleted,
            title: filterCompleted
                ? l10n.noCompletedTasks
                : l10n.noPendingTasks,
            subtitle: filterCompleted ? null : l10n.tapToCreate,
            isDark: isDark,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos.elementAt(index);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TodoItem(
                key: ValueKey(todo.id),
                todo: todo,
                onToggle: (isChecked) {
                  HapticFeedback.lightImpact();
                  context.read<TodoBloc>().add(
                    TodoCompletionToggled(todo: todo, isCompleted: isChecked),
                  );
                  if (isChecked) {
                    Future.delayed(const Duration(milliseconds: 600), () {
                      if (context.mounted) {
                        context.read<TodoBloc>().add(
                          const TodoCompletionAnimationFinished(),
                        );
                      }
                    });
                  }
                },
                onDelete: () => _handleDelete(context, todo, l10n),
                onEdit: () => _handleEdit(context, todo),
                onPin: () {
                  HapticFeedback.selectionClick();
                  context.read<TodoBloc>().add(
                    TodoUpdated(todo.copyWith(isPinned: !todo.isPinned)),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _handleDelete(BuildContext context, Todo todo, AppLocalizations l10n) {
    HapticFeedback.mediumImpact();
    final todoBloc = context.read<TodoBloc>();
    final todoToRestore = todo;

    todoBloc.add(TodoDeleted(todo.id));

    UiUtils.showSnackBar(
      context,
      message: l10n.taskDeleted,
      actionLabel: l10n.undo,
      onActionPressed: () {
        HapticFeedback.lightImpact();
        todoBloc.add(TodoAdded(todoToRestore));
      },
    );
  }

  void _handleEdit(BuildContext context, Todo todo) {
    UiUtils.showFlowBottomSheet(context, child: AddTodoSheet(todo: todo));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 48,
        height: 48,
        decoration: ShapeDecoration(
          gradient: AppColors.primaryGradient,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: const CircularProgressIndicator(
          strokeWidth: 2.5,
          color: Colors.white,
        ),
      ),
    );
  }
}
