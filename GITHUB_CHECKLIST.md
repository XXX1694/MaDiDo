# ✅ GitHub Repository Checklist

Используйте этот чеклист для настройки репозитория на GitHub.

## 🎯 Перед публикацией

- [ ] **Удалите секретные данные из git истории**
  ```bash
  # Проверьте, что эти файлы не в git
  git rm --cached android/app/upload-keystore.jks
  git rm --cached android/key.properties
  git commit -m "chore: remove sensitive files"
  ```

- [ ] **Обновите README.md**
  - [ ] Замените `YOUR_USERNAME` на ваш GitHub username
  - [ ] Добавьте скриншоты приложения
  - [ ] Обновите badges

- [ ] **Проверьте .gitignore**
  - [ ] Убедитесь что `*.jks` и `key.properties` в списке

## 📦 Создание репозитория

1. **Создайте новый репозиторий на GitHub**
   - Название: `to_do` или `flutter-todo-app`
   - Описание: "A beautiful TODO app built with Flutter"
   - Public repository
   - НЕ инициализируйте с README (у вас уже есть)

2. **Подключите локальный репозиторий**
   ```bash
   cd /Users/abzal.serikbay/Desktop/to_do
   git init
   git add .
   git commit -m "Initial commit: Flutter TODO app"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/to_do.git
   git push -u origin main
   ```

## 🔐 Настройка GitHub Secrets

Перейдите в: **Settings → Secrets and variables → Actions → New repository secret**

Добавьте следующие secrets (см. `.github/SETUP.md` для деталей):

- [ ] `KEYSTORE_BASE64` - Ваш keystore в base64
- [ ] `STORE_PASSWORD` - Пароль keystore
- [ ] `KEY_PASSWORD` - Пароль ключа
- [ ] `KEY_ALIAS` - Алиас ключа (upload)
- [ ] `PLAYSTORE_SERVICE_ACCOUNT_JSON` - Service account JSON в base64

### Как закодировать keystore в base64

```bash
cd android/app
base64 -i upload-keystore.jks | pbcopy
# На Linux: base64 -w 0 upload-keystore.jks | xclip -selection clipboard
```

Вставьте в GitHub Secret.

## ⚙️ Настройка Repository Settings

### General

- [ ] **Features**
  - ✅ Issues
  - ✅ Discussions (опционально)
  - ✅ Projects (опционально)
  - ❌ Wiki (если не нужен)

### Branches

- [ ] **Add branch protection rule** для `main`:
  - Branch name pattern: `main`
  - ✅ Require a pull request before merging
  - ✅ Require status checks to pass before merging
    - Выберите: `Analyze Code`
  - ✅ Require conversation resolution before merging

### Actions

- [ ] **General**
  - ✅ Allow all actions and reusable workflows
  - ✅ Read and write permissions
  - ✅ Allow GitHub Actions to create and approve pull requests

## 📱 Google Play Console

- [ ] **Создайте приложение** в Play Console
- [ ] **Настройте App Signing**
- [ ] **Создайте Service Account**
  1. Google Cloud Console → Create Service Account
  2. Download JSON key
  3. Play Console → API Access → Grant access
  4. Права: Release Manager

- [ ] **Загрузите первую версию вручную**
  ```bash
  flutter build appbundle --release
  ```
  Загрузите в Play Console → Internal Testing

- [ ] **Добавьте Service Account JSON** в GitHub Secrets

## 🚀 Первый релиз

### Вариант 1: Через тег

```bash
git tag v1.0.0
git push origin v1.0.0
```

### Вариант 2: Вручную

1. GitHub → Actions → Release to Google Play
2. Run workflow
3. Выберите track (internal/alpha/beta)
4. Run

## 📊 Мониторинг

После настройки проверьте:

- [ ] **Actions** - Workflows запускаются
- [ ] **Issues** - Шаблоны работают
- [ ] **Pull Requests** - Template отображается
- [ ] **Dependabot** - Создает PR для обновлений

## 🎨 Опционально: Улучшения

- [ ] **GitHub Pages** для документации
- [ ] **Code coverage** badge (Codecov)
- [ ] **Social preview** image (Settings → General)
- [ ] **Topics** для лучшей видимости:
  - flutter
  - dart
  - todo-app
  - material-design
  - bloc-pattern

## 🔗 Полезные ссылки

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Google Play Publishing](https://developer.android.com/studio/publish)
- [Flutter Deployment](https://docs.flutter.dev/deployment/android)

---

## 🎉 Готово!

После завершения этого чеклиста ваш проект будет:
- ✅ Open source на GitHub
- ✅ С автоматическими проверками кода
- ✅ С автоматической публикацией на Google Play
- ✅ С профессиональной документацией

