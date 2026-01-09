import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';
import 'package:to_do/features/todo/presentation/widgets/add_todo_sheet.dart';
import 'package:to_do/features/todo/presentation/widgets/todo_item.dart';
import 'package:to_do/features/todo/presentation/widgets/filter_todo_sheet.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.myTasks,
            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 28),
          ),
          actions: [
            IconButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Theme.of(context).cardTheme.color,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => const FilterTodoSheet(),
                );
              },
              icon: const Icon(Icons.filter_list_rounded),
            ),
            BlocBuilder<TodoBloc, TodoState>(
              buildWhen: (previous, current) =>
                  previous.sortOption != current.sortOption,
              builder: (context, state) {
                return PopupMenuButton<SortOption>(
                  icon: const Icon(Icons.sort_rounded),
                  tooltip: 'Sort by',
                  initialValue: state.sortOption,
                  onSelected: (option) {
                    context.read<TodoBloc>().add(TodosSortChanged(option));
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: SortOption.createdAt,
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: state.sortOption == SortOption.createdAt
                                ? (isDark
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight)
                                : null,
                          ),
                          const Gap(8),
                          const Text('Date Created'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: SortOption.deadline,
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: state.sortOption == SortOption.deadline
                                ? (isDark
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight)
                                : null,
                          ),
                          const Gap(8),
                          const Text('Deadline'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: SortOption.alphabetical,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sort_by_alpha_rounded,
                            color: state.sortOption == SortOption.alphabetical
                                ? (isDark
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight)
                                : null,
                          ),
                          const Gap(8),
                          const Text('A-Z'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: SortOption.priority,
                      child: Row(
                        children: [
                          Icon(
                            Icons.flag_rounded,
                            color: state.sortOption == SortOption.priority
                                ? (isDark
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight)
                                : null,
                          ),
                          const Gap(8),
                          const Text('Priority'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            IconButton(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings),
            ),
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: isDark ? Colors.white : Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: isDark ? Colors.white : Colors.black,
            labelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            tabs: [
              Tab(text: l10n.toDo),
              Tab(text: l10n.done),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TodoList(filterCompleted: false),
            _TodoList(filterCompleted: true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Theme.of(context).cardTheme.color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const AddTodoSheet(),
            );
          },
          backgroundColor: isDark
              ? AppColors.primaryDark
              : AppColors.primaryLight,
          foregroundColor: isDark ? Colors.black : Colors.white,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  final bool filterCompleted;

  const _TodoList({required this.filterCompleted});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        if (state.status == TodoStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final todos = filterCompleted
            ? state.completedTodos
            : state.pendingTodos;

        if (todos.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryDark.withValues(alpha: 0.1)
                          : AppColors.primaryLight.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      filterCompleted
                          ? Icons.task_alt_rounded
                          : Icons.checklist_rtl_rounded,
                      size: 64,
                      color: isDark
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                    ),
                  ),
                  const Gap(24),
                  Text(
                    filterCompleted
                        ? l10n.noCompletedTasks
                        : l10n.noPendingTasks,
                    style: GoogleFonts.inter(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(8),
                  if (!filterCompleted)
                    Text(
                      l10n.tapToCreate,
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            100,
          ), // Bottom padding for FAB
          itemCount: todos.length,
          separatorBuilder: (_, __) => const Gap(12),
          itemBuilder: (context, index) {
            final todo = todos.elementAt(index);
            return TodoItem(
              key: ValueKey(todo.id),
              todo: todo,
              onToggle: (isChecked) {
                HapticFeedback.lightImpact();
                context.read<TodoBloc>().add(
                  TodoCompletionToggled(todo: todo, isCompleted: isChecked),
                );
              },
              onDelete: () {
                HapticFeedback.mediumImpact();

                // Capture the bloc and todo before the widget is disposed
                final todoBloc = context.read<TodoBloc>();
                final todoToRestore = todo;

                // Delete the todo
                todoBloc.add(TodoDeleted(todo.id));

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: Text(
                      l10n.taskDeleted,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                    action: SnackBarAction(
                      label: l10n.undo,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        // Use the captured bloc and original todo
                        todoBloc.add(TodoAdded(todoToRestore));
                      },
                    ),
                  ),
                );
              },
              onEdit: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Theme.of(context).cardTheme.color,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => AddTodoSheet(todo: todo),
                );
              },
              onPin: () {
                HapticFeedback.selectionClick();
                context.read<TodoBloc>().add(
                  TodoUpdated(todo.copyWith(isPinned: !todo.isPinned)),
                );
              },
            );
          },
        );
      },
    );
  }
}
