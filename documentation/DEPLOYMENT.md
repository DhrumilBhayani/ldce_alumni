# LDCE Connect — Deployment Guide

---

## 1. Prerequisites

### Development Environment

| Requirement | Version | Purpose |
|---|---|---|
| **Flutter SDK** | ≥2.17.1 <3.0.0 | Framework |
| **Dart SDK** | ≥2.17.1 <3.0.0 | Language runtime |
| **Android Studio** | Latest | Android build tools, emulators |
| **Xcode** | Latest (macOS only) | iOS builds, simulators |
| **JDK** | 1.8+ | Android Gradle builds |
| **Git** | Latest | Version control |

### Accounts & Services

| Service | Purpose | Required |
|---|---|---|
| **Firebase Console** | Push notifications, analytics | Yes |
| **Google Play Console** | Android app distribution | For Android release |
| **Apple Developer Account** | iOS app distribution | For iOS release |
| **Backend API Server** | REST API hosting | Yes |

---

## 2. Environment Setup

### 2.1 Clone and Install

```bash
# Clone the repository
git clone <repository-url>
cd ldce_alumni

# Install Flutter dependencies
flutter pub get
```

### 2.2 Firebase Configuration

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select the project linked to `net.ldcealumni`
3. Ensure the following files are in place:

| Platform | Config File | Location |
|---|---|---|
| Android | `google-services.json` | `android/app/google-services.json` |
| iOS | `GoogleService-Info.plist` | `ios/Runner/GoogleService-Info.plist` |

> **⚠️ Important:** These files contain Firebase project credentials and are typically excluded from version control. Ensure they are present before building.

### 2.3 API Configuration

The base API URL is configured in `lib/core/globals.dart`:

```dart
// Sandbox/Development
const String BASE_API_URL = 'https://ldcealumniapi.devitsandbox.com/api/';

// Production (uncomment for production builds)
// const String BASE_API_URL = 'http://api.ldcealumni.net/api/';
```

**To switch environments:**
1. Open `lib/core/globals.dart`
2. Comment out the sandbox URL
3. Uncomment the production URL
4. Rebuild the app

> **💡 Recommendation:** Consider using environment variables or build flavors for cleaner environment switching.

---

## 3. Development Build

### 3.1 Run on Emulator/Device

```bash
# Check connected devices
flutter devices

# Run in debug mode (default)
flutter run

# Run on specific device
flutter run -d <device_id>

# Run with verbose logging
flutter run --verbose
```

### 3.2 Hot Reload & Hot Restart

- **Hot Reload:** Press `r` in the terminal (preserves state)
- **Hot Restart:** Press `R` in the terminal (resets state)

---

## 4. Android Build & Release

### 4.1 Signing Configuration

The app uses a keystore for release signing. The keystore configuration is defined in `android/app/build.gradle`:

```groovy
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
```

**Setup `key.properties`:**

Create a file at `android/key.properties` with:

```properties
storePassword=<your_keystore_password>
keyPassword=<your_key_password>
keyAlias=<your_key_alias>
storeFile=<path_to_keystore_file>
```

**Existing Keystore Files:**

| File | Location | Purpose |
|---|---|---|
| `upload-keystore.jks` | Project root | Android upload signing key |
| `upload_certificate.pem` | Project root | Play Store upload certificate |

> **⚠️ Security Warning:** Never commit `key.properties` or keystore files to version control. Add them to `.gitignore`.

### 4.2 Android Build Configuration

| Property | Value |
|---|---|
| **Application ID** | `net.ldcealumni` |
| **Min SDK** | 21 (Android 5.0 Lollipop) |
| **Target SDK** | 33 (Android 13) |
| **Compile SDK** | Flutter default |
| **Java Compatibility** | Java 1.8 |
| **Kotlin JVM Target** | 1.8 |
| **Minify Enabled** | `false` |
| **Shrink Resources** | `false` |

### 4.3 Build APK

```bash
# Build release APK
flutter build apk --release

# Build with specific version
flutter build apk --build-name=1.0.5 --build-number=7

# Output location
# build/app/outputs/flutter-apk/app-release.apk
```

### 4.4 Build App Bundle (for Play Store)

```bash
# Build AAB (recommended for Play Store)
flutter build appbundle --release

# Output location
# build/app/outputs/bundle/release/app-release.aab
```

### 4.5 Play Store Deployment

1. Build the release AAB: `flutter build appbundle --release`
2. Sign in to [Google Play Console](https://play.google.com/console)
3. Navigate to your app → **Production** → **Create new release**
4. Upload the AAB file from `build/app/outputs/bundle/release/app-release.aab`
5. Add release notes describing changes
6. Submit for review

---

## 5. iOS Build & Release

### 5.1 Prerequisites (macOS only)

```bash
# Install CocoaPods
sudo gem install cocoapods

# Navigate to iOS folder and install pods
cd ios
pod install
cd ..
```

### 5.2 Build iOS

```bash
# Build iOS release
flutter build ios --release

# Build IPA for distribution
flutter build ipa --release

# Output location
# build/ios/ipa/ldce_alumni.ipa
```

### 5.3 App Store Deployment

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select **Product** → **Archive**
3. Use **Xcode Organizer** to upload to App Store Connect
4. Alternatively, use `flutter build ipa` and upload via **Transporter** app
5. Submit for App Store review

### 5.4 iOS Configuration

Ensure the following are configured in Xcode:
- **Bundle Identifier:** Matches your Apple Developer profile
- **Signing & Capabilities:** Automatic or manual code signing
- **Push Notifications:** Capability enabled with proper provisioning profile

---

## 6. Native Splash Screen

The app uses `flutter_native_splash` for the launch screen. Configuration is in `flutter_native_splash.yaml`:

```bash
# Generate splash screen assets
flutter pub run flutter_native_splash:create
```

---

## 7. Push Notification Configuration

### 7.1 Firebase Cloud Messaging Topics

The app subscribes to FCM topics based on platform and build mode:

| Topic | Platforms | Build Mode |
|---|---|---|
| `all-android` | Android | All |
| `all-ios` | iOS | All |
| `all-dhrumil` | All | All |
| `all-dhrumil-dev-11` | All | Debug only |
| `all` | All | Debug only |
| `all-dhrumil-b-sandbox` | All | Debug only |

### 7.2 Notification Settings

```dart
// Foreground notification presentation
FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true,
  badge: true,
  sound: true,
);
```

---

## 8. Build Flavors & Environment Management

### Current Setup

The project currently uses manual URL switching in `globals.dart`. For production-grade deployments, consider implementing build flavors:

### Recommended Flutter Flavors

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```

### Environment Configuration Checklist

| Setting | Development | Staging | Production |
|---|---|---|---|
| **API URL** | `localhost:xxxx/api/` | `ldcealumniapi.devitsandbox.com/api/` | `api.ldcealumni.net/api/` |
| **FCM Topics** | Dev-specific | Staging | Production |
| **Debug Banner** | Shown | Hidden | Hidden |
| **Print Statements** | Active | Active | Suppressed |
| **Minification** | Off | Off | Recommended On |

---

## 9. Troubleshooting

### Common Issues

| Issue | Solution |
|---|---|
| `flutter pub get` fails | Run `flutter clean` then `flutter pub get` |
| Gradle build fails | Check Java version, update Gradle wrapper |
| iOS build fails | Run `cd ios && pod install --repo-update` |
| Firebase initialization error | Verify `google-services.json` / `GoogleService-Info.plist` |
| API connection timeout | Check network, verify `BASE_API_URL` in globals |
| Signing error (Android) | Verify `key.properties` file and keystore paths |

### Useful Commands

```bash
# Clean build artifacts
flutter clean

# Analyze code for issues
flutter analyze

# Run tests
flutter test

# Check Flutter installation
flutter doctor -v

# Update Flutter SDK
flutter upgrade

# Get dependency tree
flutter pub deps
```

---

## 10. Version History

| Version | Build | Date | Notes |
|---|---|---|---|
| 1.0.5 | 7 | Current | Latest release |

---

## 11. Post-Deployment Checklist

- [ ] Verify API `BASE_API_URL` points to production
- [ ] Ensure Firebase config files are correct for production project
- [ ] Verify keystore/signing configuration
- [ ] Confirm FCM topic subscriptions are set for production
- [ ] Debug print statements are suppressed in release mode
- [ ] Test push notifications end-to-end
- [ ] Verify internet connectivity handling
- [ ] Test deep linking for news and events
- [ ] Confirm profile authentication flow works
- [ ] Review app version and build number
- [ ] Test on both Android and iOS devices
- [ ] Verify splash screen displays correctly
