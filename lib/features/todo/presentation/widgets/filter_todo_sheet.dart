import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/features/todo/domain/entities/todo_category.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';

class FilterTodoSheet extends StatelessWidget {
  const FilterTodoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Tasks',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (state.filterCategoryId != null ||
                      state.filterPriority != null)
                    TextButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                          const TodosFilterChanged(
                            categoryId: null,
                            priority: null,
                          ),
                        );
                      },
                      child: const Text('Clear All'),
                    ),
                ],
              ),
              const Gap(16),

              // Priority Filter
              Text(
                'Priority',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              Wrap(
                spacing: 8,
                children: TodoPriority.values.map((priority) {
                  final isSelected = state.filterPriority == priority;
                  return FilterChip(
                    label: Text(priority.name.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      context.read<TodoBloc>().add(
                        TodosFilterChanged(
                          categoryId: state.filterCategoryId,
                          priority: selected ? priority : null,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              const Gap(16),

              // Category Filter
              Text(
                'Category',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              Wrap(
                spacing: 8,
                children: TodoCategory.defaultCategories.map((category) {
                  final isSelected = state.filterCategoryId == category.id;
                  final color = Color(category.colorValue);
                  return FilterChip(
                    label: Text(category.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      context.read<TodoBloc>().add(
                        TodosFilterChanged(
                          categoryId: selected ? category.id : null,
                          priority: state.filterPriority,
                        ),
                      );
                    },
                    selectedColor: color.withOpacity(0.2),
                    checkmarkColor: color,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? color
                          : (isDark ? Colors.white : Colors.black),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    side: isSelected ? BorderSide(color: color) : null,
                  );
                }).toList(),
              ),
              const Gap(24),
            ],
          ),
        );
      },
    );
  }
}
