insta# LDCE Connect — Project Setup Guide

> Complete step-by-step guide for setting up the project from scratch on a new machine.

---

## 1. Prerequisites Installation

### 1.1 Install Flutter SDK

```bash
# Option A: Download from flutter.dev
# Visit: https://docs.flutter.dev/get-started/install/windows
# Extract to C:\flutter
# Add C:\flutter\bin to your system PATH

# Option B: Using Chocolatey (Windows)
choco install flutter

# Option C: Using winget
winget install Flutter.Flutter
```

After installation, verify:

```bash
flutter --version
# Expected: Flutter 3.x.x (channel stable)

flutter doctor -v
# Should show: Flutter, Android toolchain, Chrome, Visual Studio
```

### 1.2 Install Dart SDK

Dart comes bundled with Flutter. Verify:

```bash
dart --version
# Expected: Dart SDK version >=2.17.1
```

### 1.3 Install Android Studio

1. Download from [developer.android.com/studio](https://developer.android.com/studio)
2. Install the following SDK components via SDK Manager:
   - Android SDK Platform 33 (Android 13)
   - Android SDK Build-Tools 33.x
   - Android SDK Command-line Tools
   - Android Emulator
3. Accept licenses: `flutter doctor --android-licenses`

### 1.4 Install VS Code Extensions (Optional)

- Flutter
- Dart
- Flutter Widget Snippets

---

## 2. Project Setup

### 2.1 Clone Repository

```bash
git clone <repository-url>
cd ldce_alumni
```

### 2.2 Environment Files Setup

The project uses environment files for configuration. Templates are provided:

```bash
# Copy environment template (already created if you followed this guide)
# The .env file should already exist for development
# For production builds, copy .env.production values
```

**Environment files:**

| File | Purpose | Git Tracked |
|---|---|---|
| `.env.example` | Template with all config keys | ✅ Yes |
| `.env` | Active development config | ❌ No |
| `.env.production` | Production config | ❌ No |

### 2.3 Firebase Configuration

Ensure Firebase config files are in the correct locations:

```
android/app/google-services.json          ← Android Firebase config
ios/Runner/GoogleService-Info.plist       ← iOS Firebase config (if building iOS)
```

> **Note:** These files are excluded from Git. Get them from:
> 1. [Firebase Console](https://console.firebase.google.com/) → Project `ldce-alumni-bd8d4`
> 2. Project Settings → Your Apps → Download config

### 2.4 Android Signing Setup

For release builds, create the signing configuration:

```bash
# Copy the template
cp android/key.properties.example android/key.properties

# Edit android/key.properties with your actual values:
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=../../upload-keystore.jks
```

> **⚠️ Important:** The keystore file `upload-keystore.jks` must be present in the project root.

### 2.5 Install Dependencies

```bash
# Clean any stale build artifacts
flutter clean

# Get all packages
flutter pub get
```

This installs all 17+ runtime dependencies:

| Package | Version | Purpose |
|---|---|---|
| provider | ^6.0.5 | State management |
| http | ^1.1.0 | REST API client |
| firebase_core | ^2.15.1 | Firebase init |
| firebase_messaging | ^14.6.7 | Push notifications |
| cached_network_image | ^3.2.3 | Image caching |
| carousel_slider | ^4.2.1 | Image carousels |
| shimmer | ^3.0.0 | Loading effects |
| flutter_secure_storage | latest | Secure storage |
| shared_preferences | ^2.2.1 | Preferences |
| google_fonts | ^6.0.0 | Typography |
| flutter_html | ^3.0.0-beta.2 | HTML rendering |
| dropdown_button2 | ^2.3.9 | Dropdowns |
| sticky_headers | ^0.3.0+2 | Sticky headers |
| url_launcher | ^6.1.14 | URL opening |
| fluttertoast | ^8.2.2 | Toast messages |
| package_info_plus | ^4.1.0 | App info |
| intl | ^0.18.1 | Internationalization |
| path_provider | ^2.1.1 | File paths |

### 2.6 Generate Native Splash Screen

```bash
flutter pub run flutter_native_splash:create
```

---

## 3. Running the Project

### 3.1 Check Devices

```bash
flutter devices
```

### 3.2 Run in Development

```bash
# Run on default device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run on Chrome (web)
flutter run -d chrome

# Run with verbose output
flutter run --verbose
```

### 3.3 Hot Reload

While the app is running:
- Press `r` → Hot Reload (preserves state)
- Press `R` → Hot Restart (resets state)
- Press `q` → Quit

---

## 4. Project Structure Overview

```
ldce_alumni/
├── .env                        ← Active environment config
├── .env.example                ← Template (committed to git)
├── .env.production             ← Production config
├── .gitignore                  ← Git exclusion rules
├── pubspec.yaml                ← Dependencies & assets
├── flutter_native_splash.yaml  ← Splash screen config
│
├── lib/
│   ├── main.dart               ← App entry point
│   ├── config/
│   │   └── env_config.dart     ← Dart environment config
│   ├── controllers/            ← Business logic (9 controllers)
│   ├── models/                 ← Data models + API (9 models)
│   ├── views/                  ← UI screens (65+ files)
│   ├── core/                   ← Global utilities
│   ├── extensions/             ← Dart extensions
│   ├── localizations/          ← i18n support
│   ├── theme/                  ← App theming
│   └── utils/                  ← Utilities
│
├── android/
│   ├── app/
│   │   ├── build.gradle        ← Android build config
│   │   ├── google-services.json← Firebase config
│   │   └── src/                ← Android source
│   ├── key.properties.example  ← Signing template
│   └── build.gradle            ← Root Gradle config
│
├── assets/
│   ├── fonts/                  ← Custom fonts
│   ├── icons/                  ← App icons
│   ├── images/                 ← Static images
│   └── lang/                   ← Language files
│
├── documentation/              ← Project documentation
│   ├── Project_Overview.md
│   ├── ARCHITECTURE.md
│   ├── API_DOCUMENTATION.md
│   ├── DEPLOYMENT.md
│   └── SETUP.md                ← This file
│
└── upload-keystore.jks         ← Android signing keystore
```

---

## 5. Environment Configuration

### 5.1 Dart Environment Config (lib/config/env_config.dart)

The `EnvConfig` class centralizes all environment-specific values:

```dart
import 'package:ldce_alumni/config/env_config.dart';

// Access configuration values
final apiUrl = EnvConfig.apiBaseUrl;
final timeout = EnvConfig.httpTimeout;
final isProd = EnvConfig.isProduction;
```

**To switch environments**, edit `lib/config/env_config.dart`:

```dart
// Change this line:
static const Environment currentEnvironment = Environment.development;

// To:
static const Environment currentEnvironment = Environment.production;
```

### 5.2 Environment Comparison

| Setting | Development | Production |
|---|---|---|
| API URL | `ldcealumniapi.devitsandbox.com` | `api.ldcealumni.net` |
| Debug Logs | Enabled | Disabled |
| Dev FCM Topics | Subscribed | Not subscribed |
| Debug Banner | Shown | Hidden |

---

## 6. Verification Checklist

Run through this checklist after setup:

```bash
# ✅ 1. Flutter doctor passes
flutter doctor

# ✅ 2. Dependencies installed
flutter pub get

# ✅ 3. Project analyzes cleanly
flutter analyze

# ✅ 4. Tests pass
flutter test

# ✅ 5. App builds for Android
flutter build apk --debug

# ✅ 6. App runs on device/emulator
flutter run
```

---

## 7. Common Setup Issues

| Issue | Solution |
|---|---|
| `flutter` not recognized | Add Flutter `bin/` to system PATH |
| `Gradle build failed` | Run `flutter clean` then `flutter pub get` |
| `google-services.json` missing | Download from Firebase Console |
| `SDK not found` | Set `ANDROID_HOME` environment variable |
| `Android licenses not accepted` | Run `flutter doctor --android-licenses` |
| `Pub cache issues` | Run `flutter pub cache repair` |
| `Plugin conflicts` | Delete `.flutter-plugins` and run `flutter pub get` |
| `Dart SDK version mismatch` | Update Flutter: `flutter upgrade` |
| `iOS build fails` | Run `cd ios && pod install --repo-update` |
| `Keystore not found` | Verify `key.properties` paths are correct |

---

## 8. Quick Start Commands

```bash
# Full clean setup (recommended for first time)
flutter clean
flutter pub get
flutter pub run flutter_native_splash:create
flutter run

# Daily development
flutter run

# Build release APK
flutter build apk --release

# Build release AAB (for Play Store)
flutter build appbundle --release

# Run all tests
flutter test

# Analyze code
flutter analyze

# Update dependencies
flutter pub upgrade
```
