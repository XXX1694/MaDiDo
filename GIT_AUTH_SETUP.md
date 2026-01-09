# 🔐 Настройка Git Authentication

## Проблема

Git требует аутентификацию для push на GitHub.

## ✅ Решение 1: Personal Access Token (Рекомендуется)

### Шаг 1: Создайте Personal Access Token

1. Перейдите на GitHub: https://github.com/settings/tokens
2. Нажмите "Generate new token" → "Generate new token (classic)"
3. Дайте название: `MaDiDo Push Access`
4. Выберите scope: **repo** (все галочки)
5. Нажмите "Generate token"
6. **СКОПИРУЙТЕ TOKEN** (он больше не появится!)

### Шаг 2: Используйте token для push

```bash
cd /Users/abzal.serikbay/Desktop/to_do

# При push Git попросит username и password:
git push origin main

# Username: XXX1694
# Password: [ВСТАВЬТЕ СКОПИРОВАННЫЙ TOKEN]
```

### Шаг 3: Сохраните credentials (чтобы не вводить каждый раз)

```bash
# macOS - сохранит в Keychain
git config --global credential.helper osxkeychain

# Теперь push еще раз (последний раз введете token):
git push origin main
```

После этого Git запомнит token и больше не будет спрашивать!

---

## ✅ Решение 2: SSH Keys (Для опытных)

### Шаг 1: Сгенерируйте SSH ключ

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
# Нажимайте Enter (используйте defaults)
```

### Шаг 2: Добавьте ключ в ssh-agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Шаг 3: Скопируйте публичный ключ

```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
```

### Шаг 4: Добавьте на GitHub

1. Перейдите: https://github.com/settings/keys
2. "New SSH key"
3. Title: `MacBook`
4. Key: Вставьте скопированный ключ
5. "Add SSH key"

### Шаг 5: Переключитесь обратно на SSH

```bash
cd /Users/abzal.serikbay/Desktop/to_do
git remote set-url origin git@github.com:XXX1694/MaDiDo.git
git push origin main
```

---

## 🚀 Быстрое решение (если спешите)

Самый быстрый способ - **Personal Access Token**:

1. https://github.com/settings/tokens → Generate new token (classic)
2. Выберите **repo** scope
3. Generate token и скопируйте
4. Выполните:
   ```bash
   cd /Users/abzal.serikbay/Desktop/to_do
   git config --global credential.helper osxkeychain
   git push origin main
   # Username: XXX1694
   # Password: [ВСТАВИТЬ TOKEN]
   ```

Готово! 🎉

---

## 🆘 Если ничего не работает

Используйте GitHub Desktop или GitHub CLI:

```bash
# Установите GitHub CLI
brew install gh

# Авторизуйтесь
gh auth login

# Push
cd /Users/abzal.serikbay/Desktop/to_do
git push origin main
```

