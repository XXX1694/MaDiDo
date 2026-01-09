# 📝 Flutter TODO App

<div align="center">

[![CI Status](https://github.com/XXX1694/MaDiDo/workflows/CI%20-%20Analyze%20&%20Test/badge.svg)](https://github.com/XXX1694/MaDiDo/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.35.2-02569B?logo=flutter)](https://flutter.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

A beautiful, feature-rich TODO application built with Flutter and modern architecture patterns.

[Features](#-features) • [Screenshots](#-screenshots) • [Getting Started](#-getting-started) • [Architecture](#-architecture) • [Contributing](#-contributing)

</div>

---

## ✨ Features

- ✅ **Task Management** - Create, edit, and delete tasks effortlessly
- 🔔 **Notifications** - Get reminded about your important tasks
- 🌍 **Multi-language Support** - Available in English, Russian, and Kazakh
- 🎨 **Modern UI** - Beautiful and intuitive user interface
- 💾 **Local Storage** - Fast and reliable data persistence with Isar
- 🌙 **Theme Support** - Light and dark mode
- 📱 **Cross-Platform** - Works on Android and iOS
- 🔄 **State Management** - Built with BLoC pattern for scalable architecture
- 🎯 **Clean Architecture** - Organized and maintainable codebase

## 📱 Screenshots

> Add your app screenshots here

## 🚀 Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.35.2 or higher)
- [Dart](https://dart.dev/get-dart) (3.9.0 or higher)
- Android Studio / Xcode for mobile development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/XXX1694/MaDiDo.git
   cd to_do
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗 Architecture

This project follows **Clean Architecture** principles with the **BLoC** pattern for state management.

```
lib/
├── core/               # Core utilities and configurations
│   ├── services/       # App-wide services
│   ├── theme/          # Theme configurations
│   └── utils/          # Utility functions
├── features/           # Feature modules
│   ├── todo/           # TODO feature
│   │   ├── data/       # Data layer (repositories, data sources)
│   │   ├── domain/     # Domain layer (entities, use cases)
│   │   └── presentation/ # UI layer (pages, widgets, BLoC)
│   └── settings/       # Settings feature
├── l10n/              # Localization files
└── main.dart          # App entry point
```

### Key Technologies

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Database**: [Isar](https://pub.dev/packages/isar)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Notifications**: [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- **UI**: [Material Design 3](https://m3.material.io/)

## 🔧 Development

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

### Code Formatting

```bash
dart format .
```

### Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📦 Build Release

### Android

```bash
flutter build apk --release        # For APK
flutter build appbundle --release  # For Play Store
```

### iOS

```bash
flutter build ipa --release
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) to learn about our development process and how to propose bugfixes and improvements.

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Thanks to all [contributors](https://github.com/XXX1694/MaDiDo/graphs/contributors)
- Built with [Flutter](https://flutter.dev)
- Icons from [Material Icons](https://fonts.google.com/icons)

## 📞 Contact

- **Issues**: [GitHub Issues](https://github.com/XXX1694/MaDiDo/issues)
- **Discussions**: [GitHub Discussions](https://github.com/XXX1694/MaDiDo/discussions)

---

<div align="center">
Made with ❤️ and Flutter
</div>
