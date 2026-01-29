import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/core/theme/flow_colors.dart';
import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';
import 'package:to_do/features/todo/presentation/widgets/filter_todo_sheet.dart';
import 'package:to_do/features/todo/presentation/widgets/home/home_icon_button.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.flowColors;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                l10n.appTitle,
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: colors.textPrimary,
                ),
              ),
            ),
            BlocBuilder<TodoBloc, TodoState>(
              buildWhen: (previous, current) =>
                  previous.filterCategoryId != current.filterCategoryId ||
                  previous.filterPriority != current.filterPriority,
              builder: (context, state) {
                final hasFilter =
                    state.filterCategoryId != null ||
                    state.filterPriority != null;
                return HomeIconButton(
                  icon: Icons.filter_list_rounded,
                  isActive: hasFilter,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => Container(
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: const FilterTodoSheet(),
                      ),
                    );
                  },
                );
              },
            ),
            const Gap(4),
            _HomeSortMenu(isDark: isDark),
            const Gap(4),
            HomeIconButton(
              icon: Icons.settings_rounded,
              onTap: () => context.push('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeSortMenu extends StatelessWidget {
  const _HomeSortMenu({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.flowColors;
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) =>
          previous.sortOption != current.sortOption,
      builder: (context, state) {
        final isSortingActive = state.sortOption != SortOption.createdAt;
        return PopupMenuButton<SortOption>(
          icon: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isSortingActive
                  ? colors.primary.withValues(
                      alpha: Theme.of(context).brightness == Brightness.dark
                          ? 0.15
                          : 0.05,
                    )
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.sort_rounded,
                  color: isSortingActive ? colors.primary : colors.textPrimary,
                  size: 26,
                ),
                if (isSortingActive)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.surface, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          tooltip: l10n.sortBy,
          initialValue: state.sortOption,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: colors.surface,
          elevation: 8,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          onSelected: (option) {
            context.read<TodoBloc>().add(TodosSortChanged(option));
          },
          itemBuilder: (context) => [
            _buildSortMenuItem(
              context: context,
              icon: Icons.access_time_rounded,
              label: l10n.dateCreated,
              value: SortOption.createdAt,
              isSelected: state.sortOption == SortOption.createdAt,
            ),
            _buildSortMenuItem(
              context: context,
              icon: Icons.calendar_today_rounded,
              label: l10n.deadline,
              value: SortOption.deadline,
              isSelected: state.sortOption == SortOption.deadline,
            ),
            _buildSortMenuItem(
              context: context,
              icon: Icons.sort_by_alpha_rounded,
              label: l10n.alphabetical,
              value: SortOption.alphabetical,
              isSelected: state.sortOption == SortOption.alphabetical,
            ),
            _buildSortMenuItem(
              context: context,
              icon: Icons.flag_rounded,
              label: l10n.priority,
              value: SortOption.priority,
              isSelected: state.sortOption == SortOption.priority,
            ),
          ],
        );
      },
    );
  }

  PopupMenuItem<SortOption> _buildSortMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required SortOption value,
    required bool isSelected,
  }) {
    final colors = context.flowColors;
    return PopupMenuItem(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.primaryGradient : null,
                color: isSelected
                    ? null
                    : (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.05)
                          : AppColors.inputBackgroundLight),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : colors.textSecondary,
                size: 20,
              ),
            ),
            const Gap(12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
