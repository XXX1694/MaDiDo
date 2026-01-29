import 'package:flutter/material.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/features/todo/presentation/widgets/home/active_filters_bar.dart';
import 'package:to_do/features/todo/presentation/widgets/home/home_fab.dart';
import 'package:to_do/features/todo/presentation/widgets/home/home_header.dart';
import 'package:to_do/features/todo/presentation/widgets/home/home_tab_switcher.dart';
import 'package:to_do/features/todo/presentation/widgets/home/todo_list_view.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(isDark: isDark),
            const ActiveFiltersBar(),
            HomeTabSwitcher(
              currentIndex: _currentTabIndex,
              onTabChanged: (index) {
                _tabController.animateTo(index);
                setState(() => _currentTabIndex = index);
              },
              leftLabel: l10n.toDo,
              rightLabel: l10n.done,
              isDark: isDark,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  TodoListView(filterCompleted: false),
                  TodoListView(filterCompleted: true),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: HomeFab(isDark: isDark),
    );
  }
}
