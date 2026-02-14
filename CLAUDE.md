# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter TODO app ("Premium To-Do") targeting iOS and Android. Package name: `to_do`. Uses Dart 3.9+, Flutter 3.35.2.

## Common Commands

```bash
make install       # flutter pub get + build_runner code generation
make build         # Run build_runner (generates Isar models, etc.) + format
make test          # flutter test
make analyze       # flutter analyze
make format        # dart format .
make check         # format + analyze + test (all three)
```

Run a single test file:
```bash
flutter test test/path_to_test.dart
```

Release builds:
```bash
make release-android-apk   # APK with --split-per-abi
make release-android-aab   # App Bundle
make release-ios            # IPA
```

After modifying Isar models or any file with code generation annotations, run `make build` to regenerate.

## Architecture

Clean Architecture with BLoC pattern, organized by feature:

```
lib/
├── core/               # Shared: DI, services, theme, utils, widgets
├── features/
│   ├── todo/           # Main feature
│   │   ├── data/       # Isar datasource, models (generated), repository impl
│   │   ├── domain/     # Entities, repository interfaces, use cases, factories
│   │   └── presentation/  # BLoC, pages, widgets
│   └── settings/       # Settings feature (same layer structure)
└── l10n/               # ARB files (en, ru, kk) + generated localization classes
```

**Dependency injection:** GetIt service locator configured in `lib/core/service_locator.dart`. All dependencies (Isar DB, SharedPreferences, datasources, repositories, use cases, services, BLoCs) are registered there.

**State management:** `flutter_bloc`. `TodoBloc` and `SettingsBloc` are provided at the app root via `MultiBlocProvider` in `main.dart`.

**Database:** Isar (local NoSQL). Models in `data/models/` are code-generated (`*.g.dart` files). The Isar instance is opened in the service locator init.

**Navigation:** GoRouter, configured in `lib/core/utils/app_router.dart`.

**Localization:** 3 languages (English, Russian, Kazakh). ARB source files in `lib/l10n/`, generated output in `lib/l10n/generated/`. Config in `l10n.yaml`.

## Linting

Uses `very_good_analysis` with additional strict rules. Key enforced rules:
- `require_trailing_commas`
- `prefer_single_quotes`
- `always_use_package_imports`
- `prefer_final_locals` / `prefer_final_in_for_each`
- `prefer_const_constructors`
- `sort_constructors_first`

Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from analysis.

## CI

GitHub Actions runs on PRs: format check, `flutter analyze --fatal-infos`, tests with coverage, Android APK build. See `.github/workflows/analyze.yml`.
