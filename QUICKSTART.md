# 🚀 Quick Start Guide

Get your Flutter TODO app up and running in minutes!

## 📱 For Users

### Download

- **Google Play**: [Coming Soon]
- **APK**: Download from [Releases](https://github.com/YOUR_USERNAME/to_do/releases)

## 👨‍💻 For Developers

### Quick Setup

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/to_do.git
cd to_do

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Project Structure

```
lib/
├── main.dart              # App entry point
├── core/                  # Core utilities
│   ├── services/          # Services (notifications, etc.)
│   ├── theme/             # App theming
│   └── utils/             # Utilities
└── features/              # Feature modules
    ├── todo/              # TODO feature
    │   ├── data/          # Data layer
    │   ├── domain/        # Business logic
    │   └── presentation/  # UI
    └── settings/          # Settings feature
```

### Common Commands

```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Build APK
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## 🌍 Adding Translations

1. Edit ARB files in `lib/l10n/`:
   - `app_en.arb` - English
   - `app_ru.arb` - Russian
   - `app_kk.arb` - Kazakh

2. Generate localization:
   ```bash
   flutter pub get
   ```

## 🎨 Customizing Theme

Edit `lib/core/theme/app_theme.dart` to customize colors and styles.

## 📚 Learn More

- [Full Documentation](README.md)
- [Contributing Guide](CONTRIBUTING.md)
- [Setup CI/CD](.github/SETUP.md)

## 🆘 Need Help?

- [Report a Bug](https://github.com/YOUR_USERNAME/to_do/issues/new?template=bug_report.md)
- [Request a Feature](https://github.com/YOUR_USERNAME/to_do/issues/new?template=feature_request.md)
- [Ask Questions](https://github.com/YOUR_USERNAME/to_do/discussions)

---

Happy Coding! 🎉

