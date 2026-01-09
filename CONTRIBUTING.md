# Contributing to Flutter TODO App

First off, thank you for considering contributing to Flutter TODO App! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Process](#development-process)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

## 📜 Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## 🚀 Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/to_do.git`
3. Add upstream remote: `git remote add upstream https://github.com/ORIGINAL_OWNER/to_do.git`
4. Create a new branch: `git checkout -b feature/my-new-feature`

### Development Setup

```bash
# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build

# Run the app
flutter run
```

## 🤔 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates.

**When creating a bug report, include:**
- Clear and descriptive title
- Exact steps to reproduce the problem
- Expected behavior
- Screenshots (if applicable)
- Device information (OS, Flutter version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues.

**When creating an enhancement suggestion, include:**
- Clear and descriptive title
- Detailed description of the proposed functionality
- Examples of how the feature would be used
- Why this enhancement would be useful

### Code Contributions

Looking for a place to start? Look for issues labeled:
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed
- `bug` - Something isn't working

## 💻 Development Process

### 1. Create a Branch

```bash
git checkout -b feature/amazing-feature
# or
git checkout -b fix/bug-fix
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Adding tests

### 2. Make Your Changes

- Write clean, readable code
- Follow the project's coding style
- Add/update tests as needed
- Update documentation if necessary

### 3. Test Your Changes

```bash
# Run tests
flutter test

# Run analyzer
flutter analyze

# Check formatting
dart format --set-exit-if-changed .
```

### 4. Commit Your Changes

```bash
git add .
git commit -m "feat: add amazing feature"
```

## 📝 Style Guidelines

### Dart Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` for consistent formatting
- Follow the project's linting rules in `analysis_options.yaml`

### Code Organization

```dart
// 1. Imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:to_do/core/theme/app_theme.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';

// 2. Class definition
class MyWidget extends StatelessWidget {
  // 3. Fields
  final String title;
  
  // 4. Constructor
  const MyWidget({
    super.key,
    required this.title,
  });
  
  // 5. Lifecycle methods
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 6. Public methods
  void publicMethod() {}
  
  // 7. Private methods
  void _privateMethod() {}
}
```

### Widget Guidelines

- Prefer const constructors when possible
- Extract complex widgets into separate files
- Use meaningful widget names
- Keep widgets small and focused

### State Management

- Use BLoC for business logic
- Keep UI logic in widgets
- Follow BLoC naming conventions:
  - Events: `LoadTodos`, `AddTodo`, `DeleteTodo`
  - States: `TodosInitial`, `TodosLoading`, `TodosLoaded`, `TodosError`

## 📨 Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style changes (formatting, etc.)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks

### Examples

```
feat(todo): add due date functionality

Add ability to set due dates for tasks and receive notifications

Closes #123
```

```
fix(notifications): resolve notification not showing on iOS

- Update notification permissions handling
- Fix time zone conversion issue

Fixes #456
```

## 🔄 Pull Request Process

1. **Update your fork**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Push your changes**
   ```bash
   git push origin feature/my-feature
   ```

3. **Create Pull Request**
   - Use a clear and descriptive title
   - Reference related issues
   - Describe your changes in detail
   - Include screenshots for UI changes

4. **Code Review**
   - Address review comments
   - Keep the PR updated with main branch
   - Be patient and respectful

5. **After Merge**
   - Delete your branch
   - Update your fork
   ```bash
   git checkout main
   git pull upstream main
   git push origin main
   ```

## ✅ Pull Request Checklist

- [ ] Code follows the project's style guidelines
- [ ] Self-review completed
- [ ] Code is commented where necessary
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] No new warnings from analyzer
- [ ] Commits follow conventional commits format

## 🆘 Need Help?

- 💬 Join our [Discussions](https://github.com/YOUR_USERNAME/to_do/discussions)
- 🐛 Report bugs in [Issues](https://github.com/YOUR_USERNAME/to_do/issues)
- 📧 Contact maintainers

## 🙏 Thank You!

Your contributions make this project better for everyone!

---

Happy Coding! 🚀

