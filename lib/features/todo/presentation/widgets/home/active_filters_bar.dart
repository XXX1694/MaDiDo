import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/domain/entities/todo_category.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';

class ActiveFiltersBar extends StatelessWidget {
  const ActiveFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final hasSort = state.sortOption != SortOption.createdAt;
        final hasCategory = state.filterCategoryId != null;
        final hasPriority = state.filterPriority != null;

        if (!hasSort && !hasCategory && !hasPriority) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 36,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              if (hasSort)
                _FilterChip(
                  label: _getSortLabel(state.sortOption),
                  icon: Icons.sort_rounded,
                  onRemove: () => context.read<TodoBloc>().add(
                    const TodosSortChanged(SortOption.createdAt),
                  ),
                  isDark: isDark,
                ),
              if (hasCategory)
                _FilterChip(
                  label: TodoCategory.defaultCategories
                      .firstWhere((c) => c.id == state.filterCategoryId)
                      .name,
                  icon: Icons.category_rounded,
                  onRemove: () => context.read<TodoBloc>().add(
                    TodosFilterChanged(
                      categoryId: null,
                      priority: state.filterPriority,
                    ),
                  ),
                  isDark: isDark,
                ),
              if (hasPriority)
                _FilterChip(
                  label: _getPriorityLabel(state.filterPriority!),
                  icon: Icons.flag_rounded,
                  onRemove: () => context.read<TodoBloc>().add(
                    TodosFilterChanged(
                      categoryId: state.filterCategoryId,
                      priority: null,
                    ),
                  ),
                  isDark: isDark,
                ),
            ],
          ),
        );
      },
    );
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.createdAt:
        return 'Created';
      case SortOption.deadline:
        return 'Deadline';
      case SortOption.alphabetical:
        return 'A-Z';
      case SortOption.priority:
        return 'Priority';
    }
  }

  String _getPriorityLabel(TodoPriority priority) {
    switch (priority) {
      case TodoPriority.low:
        return 'Low';
      case TodoPriority.medium:
        return 'Medium';
      case TodoPriority.high:
        return 'High';
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onRemove;
  final bool isDark;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.onRemove,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.fromLTRB(10, 4, 6, 4),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: isDark ? 0.15 : 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const Gap(6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            ),
          ),
          const Gap(4),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close_rounded, size: 12, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
