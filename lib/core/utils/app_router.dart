import 'package:go_router/go_router.dart';
import 'package:to_do/features/settings/presentation/pages/settings_page.dart';
import 'package:to_do/features/todo/presentation/pages/home_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
