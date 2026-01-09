# 🔧 GitHub Setup Guide

This guide will help you set up GitHub Actions for automated CI/CD.

## 📋 Prerequisites

Before you begin, make sure you have:
- [ ] Google Play Console account
- [ ] Android keystore file (`upload-keystore.jks`)
- [ ] Google Play Service Account JSON key

## 🔐 Setting Up GitHub Secrets

Go to your repository → Settings → Secrets and variables → Actions → New repository secret

### Required Secrets for Release Workflow

#### 1. `KEYSTORE_BASE64`

Your Android keystore file encoded in base64.

```bash
# In your project directory, run:
cd android/app
base64 -i upload-keystore.jks | pbcopy
# On Linux use: base64 -w 0 upload-keystore.jks | xclip -selection clipboard
```

Then paste the output as the secret value.

#### 2. `STORE_PASSWORD`

The password for your keystore file (currently: your store password from `key.properties`)

```
фияфд
```

#### 3. `KEY_PASSWORD`

The password for your signing key (currently: your key password from `key.properties`)

```
фияфд
```

#### 4. `KEY_ALIAS`

The alias of your signing key (currently from `key.properties`)

```
upload
```

#### 5. `PLAYSTORE_SERVICE_ACCOUNT_JSON`

Google Play service account JSON key encoded in base64.

**How to get it:**

1. Go to [Google Play Console](https://play.google.com/console)
2. Select your app
3. Go to: Setup → API access
4. Create or use existing service account
5. Download JSON key file
6. Encode it:
   ```bash
   base64 -i service-account-key.json | pbcopy
   # On Linux: base64 -w 0 service-account-key.json | xclip -selection clipboard
   ```
7. Add as secret in GitHub

## 📦 Google Play Console Setup

### Create Service Account

1. **Google Cloud Console**
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Create new project or select existing
   - Enable Google Play Android Developer API

2. **Create Service Account**
   - Go to IAM & Admin → Service Accounts
   - Create service account
   - Give it a name (e.g., "GitHub Actions")
   - Grant role: Service Account User
   - Create and download JSON key

3. **Grant Access in Play Console**
   - Go to Play Console → Setup → API access
   - Link your Google Cloud project
   - Grant access to the service account
   - Set permissions: Release Manager or Admin

### App Signing

Make sure your app is enrolled in Google Play App Signing:
- Play Console → Your App → Setup → App integrity → App signing
- Upload or create signing key

## 🚀 Using the Workflows

### CI Workflow (Automatic)

Runs automatically on:
- Pull requests
- Pushes to `main` or `develop` branches

What it does:
- ✅ Checks code formatting
- 🔍 Analyzes code for issues
- 🧪 Runs tests
- 📦 Builds APK

### Release Workflow (Manual or Tag)

**Option 1: Manual Release**
1. Go to Actions → Release to Google Play → Run workflow
2. Select track (internal/alpha/beta/production)
3. Click "Run workflow"

**Option 2: Tag Release**
```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0
```

The workflow will:
- Run tests
- Build signed AAB
- Upload to Google Play
- Create GitHub release with artifacts

## 📱 Version Management

Update version in `pubspec.yaml`:

```yaml
version: 1.0.0+1  # version_name+version_code
```

- Version name: `1.0.0` (semantic versioning)
- Version code: `1` (incremental number for Play Store)

## 🔄 Release Process

1. **Update version** in `pubspec.yaml`
2. **Update changelog** in `distribution/whatsnew/`
3. **Commit changes**
   ```bash
   git commit -am "chore: bump version to 1.0.0"
   ```
4. **Create tag**
   ```bash
   git tag v1.0.0
   git push origin main --tags
   ```
5. **Monitor** GitHub Actions for build status
6. **Check** Google Play Console for release

## 🐛 Troubleshooting

### Build Fails with "Keystore not found"

- Make sure `KEYSTORE_BASE64` secret is set correctly
- Verify the base64 encoding doesn't have line breaks

### Upload to Play Store Fails

- Verify service account has correct permissions
- Check that package name matches: `com.example.to_do`
- Ensure version code is higher than the last release

### Tests Failing

Run locally first:
```bash
flutter test
flutter analyze
dart format --set-exit-if-changed .
```

## 📚 Additional Resources

- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)
- [Google Play Publishing](https://developer.android.com/studio/publish)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🔒 Security Notes

- ⚠️ Never commit `key.properties` or `.jks` files
- ⚠️ Always use GitHub Secrets for sensitive data
- ⚠️ Rotate keys if they're accidentally exposed
- ✅ The workflows clean up sensitive files after use

---

Need help? [Open an issue](https://github.com/YOUR_USERNAME/to_do/issues)

