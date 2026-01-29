import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';
import 'package:to_do/features/todo/presentation/widgets/home/filter/filter_header.dart';
import 'package:to_do/features/todo/presentation/widgets/home/filter/priority_filter_section.dart';
import 'package:to_do/features/todo/presentation/widgets/home/filter/category_filter_section.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class FilterTodoSheet extends StatelessWidget {
  const FilterTodoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterHeader(
                title: l10n.filters,
                isDark: isDark,
                showClearButton:
                    state.filterCategoryId != null ||
                    state.filterPriority != null,
                onClearAll: () {
                  context.read<TodoBloc>().add(
                    const TodosFilterChanged(categoryId: null, priority: null),
                  );
                },
              ),
              const Gap(32),
              PriorityFilterSection(
                selectedPriority: state.filterPriority,
                onPrioritySelected: (priority) {
                  context.read<TodoBloc>().add(
                    TodosFilterChanged(
                      categoryId: state.filterCategoryId,
                      priority: priority,
                    ),
                  );
                },
                label: 'Priority',
                isDark: isDark,
              ),
              const Gap(24),
              CategoryFilterSection(
                selectedCategoryId: state.filterCategoryId,
                onCategorySelected: (id) {
                  context.read<TodoBloc>().add(
                    TodosFilterChanged(
                      categoryId: id,
                      priority: state.filterPriority,
                    ),
                  );
                },
                label: 'Category',
                isDark: isDark,
              ),
              const Gap(32),
            ],
          ),
        );
      },
    );
  }
}
