.PHONY: help install clean build test analyze format run-android run-ios release-android release-ios

help: ## Show this help message
	@echo '📱 Flutter TODO - Available commands:'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	@echo '📦 Installing dependencies...'
	@flutter pub get
	@flutter pub run build_runner build --delete-conflicting-outputs
	@echo '✅ Done!'

clean: ## Clean build files
	@echo '🧹 Cleaning...'
	@flutter clean
	@rm -rf build/
	@rm -rf .dart_tool/
	@echo '✅ Done!'

build: ## Generate code with build_runner
	@echo '🔨 Generating code...'
	@flutter pub run build_runner build --delete-conflicting-outputs
	@echo '✅ Done!'

test: ## Run tests
	@echo '🧪 Running tests...'
	@flutter test
	@echo '✅ Done!'

analyze: ## Analyze code
	@echo '🔍 Analyzing code...'
	@flutter analyze
	@echo '✅ Done!'

format: ## Format code
	@echo '✨ Formatting code...'
	@dart format .
	@echo '✅ Done!'

check: analyze test ## Run analyze and tests
	@echo '✅ All checks passed!'

run-android: ## Run on Android device/emulator
	@echo '🤖 Running on Android...'
	@flutter run

run-ios: ## Run on iOS simulator
	@echo '🍎 Running on iOS...'
	@flutter run

release-android-apk: ## Build Android APK
	@echo '📦 Building Android APK...'
	@flutter build apk --release --split-per-abi
	@echo '✅ APK built successfully!'
	@echo '📍 Location: build/app/outputs/flutter-apk/'

release-android-aab: ## Build Android App Bundle
	@echo '📦 Building Android App Bundle...'
	@flutter build appbundle --release
	@echo '✅ AAB built successfully!'
	@echo '📍 Location: build/app/outputs/bundle/release/'

release-ios: ## Build iOS IPA
	@echo '📦 Building iOS IPA...'
	@flutter build ipa --release
	@echo '✅ IPA built successfully!'

setup-github: ## Encode keystore for GitHub
	@echo '🔐 Encoding keystore...'
	@./scripts/encode_keystore.sh

git-push: check ## Check code and push to git
	@echo '🚀 Pushing to git...'
	@git add .
	@read -p "Commit message: " msg; \
	git commit -m "$$msg"
	@git push
	@echo '✅ Done!'

version-bump: ## Bump version (usage: make version-bump VERSION=1.0.1)
	@if [ -z "$(VERSION)" ]; then \
		echo "❌ Error: VERSION not specified"; \
		echo "Usage: make version-bump VERSION=1.0.1"; \
		exit 1; \
	fi
	@echo '📝 Updating version to $(VERSION)...'
	@sed -i '' 's/^version: .*/version: $(VERSION)/' pubspec.yaml
	@echo '✅ Done! Don'\''t forget to update CHANGELOG.md'

release-tag: ## Create release tag (usage: make release-tag VERSION=1.0.1)
	@if [ -z "$(VERSION)" ]; then \
		echo "❌ Error: VERSION not specified"; \
		echo "Usage: make release-tag VERSION=1.0.1"; \
		exit 1; \
	fi
	@echo '🏷️  Creating tag v$(VERSION)...'
	@git tag v$(VERSION)
	@git push origin v$(VERSION)
	@echo '✅ Tag created! GitHub Actions will build and release.'

deps-outdated: ## Check outdated dependencies
	@echo '📦 Checking outdated dependencies...'
	@flutter pub outdated

deps-upgrade: ## Upgrade dependencies
	@echo '⬆️  Upgrading dependencies...'
	@flutter pub upgrade
	@echo '✅ Done!'

icons: ## Generate app icons
	@echo '🎨 Generating app icons...'
	@flutter pub run flutter_launcher_icons
	@echo '✅ Done!'

splash: ## Generate splash screen
	@echo '🎨 Generating splash screen...'
	@flutter pub run flutter_native_splash:create
	@echo '✅ Done!'

doctor: ## Run flutter doctor
	@flutter doctor -v

devices: ## List connected devices
	@flutter devices

