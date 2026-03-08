# LDCE Connect — Project Overview

> **Version:** 1.0.5+7 · **Package:** `net.ldcealumni` · **SDK:** Dart ≥2.17.1 <3.0.0

---

## 1. Introduction

**LDCE Connect** is a cross-platform mobile application built with **Flutter** that serves as a comprehensive digital hub for the **L.D. College of Engineering (LDCE)** alumni community. The app provides personalized access to alumni networking, institutional events, news, media galleries, noteworthy achievements, digital downloads, and project highlights — available 24×7 with real-time push notifications.

### Target Audience

| Stakeholder | Usage |
|---|---|
| LDCE Alumni | Directory search, networking, profile management |
| Current Students | Event awareness, project participation |
| Alumni Office Staff | Content push via backend CMS, announcements |
| General Public | Browse public events, news, and media |

---

## 2. Key Features

| Feature | Description |
|---|---|
| **Home Dashboard** | Image carousel/slider with latest content from all modules |
| **Alumni Directory** | Searchable directory with filters (name, batch year, branch, degree, membership type) |
| **Events** | Upcoming & past events with detail views, attachments, venue info |
| **News** | Paginated news feed with cover images, HTML content, and attachments |
| **Media Gallery** | Photo galleries with cover images and attachment lists |
| **Noteworthy Achievements** | Alumni accomplishments with alumni-specific metadata |
| **Digital Downloads** | Mobile skins, desktop wallpapers, calendars, campaign materials, other resources |
| **Projects** | Dedicated pages for Tree Plantation and AT Hackathon initiatives |
| **User Profile** | Authenticated alumni profile with personal, academic, and professional details |
| **Authentication** | OAuth2 password-grant login with secure token storage |
| **Push Notifications** | Firebase Cloud Messaging with platform-specific topic subscriptions |
| **Localization** | Multi-language support via custom localization delegates |
| **Theming** | Light & Dark theme support with Google Fonts (Montserrat) |
| **Offline Handling** | Internet connectivity checks with dedicated "No Internet" screen |

---

## 3. Technology Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Provider (`ChangeNotifier`) |
| Networking | `http` package (REST API) |
| Push Notifications | Firebase Cloud Messaging (`firebase_messaging`) |
| Backend Services | Firebase Core (`firebase_core`) |
| Local Storage | `flutter_secure_storage`, `shared_preferences` |
| Image Caching | `cached_network_image` |
| UI Components | `carousel_slider`, `shimmer`, `dropdown_button2`, `sticky_headers`, `flutter_html` |
| Fonts | Google Fonts (`google_fonts`), custom Montserrat & CustomBadge fonts |
| Icons | `flutter_feather_icons`, `material_design_icons_flutter`, `cupertino_icons` |
| URL Handling | `url_launcher` |
| Splash Screen | `flutter_native_splash` |
| Package Info | `package_info_plus` |
| Toast Messages | `fluttertoast` |

---

## 4. Project Structure

```
ldce_alumni/
├── lib/
│   ├── main.dart                          # App entry point, Firebase init, Provider setup, routing
│   ├── controllers/                       # Business logic (ChangeNotifier controllers)
│   │   ├── alumni/alumni_controller.dart
│   │   ├── auth/auth_controller.dart
│   │   ├── digital_downloads/digital_downloads_controller.dart
│   │   ├── events/events_controller.dart
│   │   ├── home/home_controller.dart
│   │   ├── media/media_controller.dart
│   │   ├── news/news_controller.dart
│   │   ├── noteworthy/noteworthy_controller.dart
│   │   └── profile/profile_controller.dart
│   ├── models/                            # Data models & API service layer
│   │   ├── alumni/alumni.dart
│   │   ├── auth/login.dart
│   │   ├── digital_downloads/digital_downloads.dart
│   │   ├── events/events.dart
│   │   ├── home/home.dart
│   │   ├── media/media.dart
│   │   ├── news/news.dart
│   │   ├── noteworthy/noteworthy.dart
│   │   └── profile/profile.dart
│   ├── views/                             # UI screens and widgets
│   │   ├── alumni_directory/              # Alumni directory home
│   │   ├── auth/Login/                    # Login screen with components
│   │   ├── digital_downloads/             # 7 download sub-screens
│   │   ├── events/                        # Event home, upcoming, past, single views
│   │   ├── general/                       # About us, membership, error screens
│   │   ├── home/                          # Tabbed home screen with 7 tabs
│   │   ├── media/                         # Media home & single media view
│   │   ├── news/                          # News home, single, notification views
│   │   ├── noteworthy/                    # Noteworthy home & single view
│   │   ├── profile/                       # User profile page
│   │   ├── projects/                      # Tree plantation & AT Hackathon
│   │   └── widgets/                       # 20+ reusable UI widgets
│   ├── core/                              # Globals, utility functions, custom widgets
│   ├── extensions/                        # Dart extensions (String, DateTime, int, etc.)
│   ├── localizations/                     # i18n delegate, language config, translator
│   ├── theme/                             # AppTheme, CustomTheme, MaterialTheme, NavigationTheme
│   └── utils/                             # Utility classes (custom badge icons)
├── assets/
│   ├── fonts/                             # CustomBadge.ttf, montserrat.ttf
│   ├── icons/                             # App icons
│   ├── images/                            # Static images & banners
│   └── lang/                              # Language files (5 locales)
├── android/                               # Android platform project
├── ios/                                   # iOS platform project
├── web/                                   # Web support (experimental)
├── windows/                               # Windows support
├── pubspec.yaml                           # Dependency declarations
└── documentation/                         # This documentation folder
```

---

## 5. Application Routes

| Route Name | Screen | Description |
|---|---|---|
| `home` | `HomeScreen` | Main dashboard (initial route) |
| `events_home` | `EventHomeScreen` | Events listing (upcoming + past) |
| `media_home` | `MediaHomeScreen` | Media gallery listing |
| `news_home` | `NewsHomeScreen` | News feed |
| `noteworthy_home` | `NoteworthyHomeScreen` | Noteworthy achievements |
| `alumni_directory_home` | `AlumniDirectoryHome` | Alumni search & directory|
| `downloads_home` | `DownloadsHomeScreen` | Digital downloads hub |
| `tree_plantation` | `TreePlantationScreen` | Tree plantation project |
| `at_hackathon` | `ATHackathon` | AT Hackathon project |
| `about_us` | `AboutUsScreen` | About the alumni association |
| `membership_types` | `MemberShipTypes` | Membership information |
| `login` | `LoginScreen` | User authentication |
| `profile` | `ProfileScreen` | Authenticated user profile |
| `single_internet_news_screen` | `SingleInternetNewsScreen` | Deep-linked news detail |
| `single_internet_events_screen` | `SingleInternetEventScreen` | Deep-linked event detail |
| `something_wrong` | `SomethingWrongScreen` | Generic error screen |
| `no_internet_screen` | `NoInternetScreen` | No connectivity screen |

---

## 6. State Management

The application uses the **Provider** pattern with `ChangeNotifier` mixin. All 9 controllers are registered as providers at the app root via `MultiProvider`:

```dart
MultiProvider(providers: [
  ChangeNotifierProvider(create: (_) => AppNotifier()),      // Theme state
  ChangeNotifierProvider(create: (_) => HomeController()),    // Home dashboard
  ChangeNotifierProvider(create: (_) => EventsController()),  // Events
  ChangeNotifierProvider(create: (_) => MediaController()),   // Media
  ChangeNotifierProvider(create: (_) => NoteworthyController()),
  ChangeNotifierProvider(create: (_) => AlumniDirectoryController()),
  ChangeNotifierProvider(create: (_) => NewsController()),
  ChangeNotifierProvider(create: (_) => DigitalDownloadsController()),
  ChangeNotifierProvider(create: (_) => AuthController()),
  ChangeNotifierProvider(create: (_) => ProfileController()),
])
```

---

## 7. Backend API

- **Base URL (Sandbox):** `https://ldcealumniapi.devitsandbox.com/api/`
- **Production URL:** `http://api.ldcealumni.net/api/` *(commented out in code)*
- **Protocol:** RESTful HTTP (GET/POST)
- **Authentication:** OAuth2 Bearer Token (password grant)
- **Response Format:** JSON with `{ Status, Message, Result }` wrapper

> See [API_DOCUMENTATION.md](./API_DOCUMENTATION.md) for full endpoint reference.

---

## 8. Security

| Feature | Implementation |
|---|---|
| Token Storage | `flutter_secure_storage` with Android encrypted shared preferences |
| Auth Tokens | OAuth2 `access_token` stored securely, passed as `Bearer` header |
| Keystore | `upload-keystore.jks` for Android release signing |
| Certificate | `upload_certificate.pem` for Play Store upload |
| SharedPrefs Config | Custom prefix (`kbca_`) with encrypted preferences |

---

## 9. Platform Support

| Platform | Status | Min Version |
|---|---|---|
| **Android** | ✅ Production | minSdk 21 (Android 5.0), targetSdk 33 |
| **iOS** | ✅ Supported | Configured via Xcode project |
| **Web** | ⚠️ Experimental | Basic web shell present |
| **Windows** | ⚠️ Experimental | Flutter desktop support |

---

## 10. Build & Version Info

| Property | Value |
|---|---|
| App Version | `1.0.5+7` |
| Application ID | `net.ldcealumni` |
| Dart SDK | `>=2.17.1 <3.0.0` |
| Orientation | Portrait only (up & down) |
| Debug Banner | Disabled |

---

## 11. Dependencies Summary

### Runtime Dependencies (17 packages)

| Package | Version | Purpose |
|---|---|---|
| `provider` | ^6.0.5 | State management |
| `http` | ^1.1.0 | REST API calls |
| `firebase_core` | ^2.15.1 | Firebase initialization |
| `firebase_messaging` | ^14.6.7 | Push notifications |
| `cached_network_image` | ^3.2.3 | Image caching |
| `carousel_slider` | ^4.2.1 | Image carousels |
| `shimmer` | ^3.0.0 | Loading effects |
| `flutter_secure_storage` | latest | Secure key-value storage |
| `shared_preferences` | ^2.2.1 | App preferences |
| `google_fonts` | ^6.0.0 | Typography |
| `flutter_html` | ^3.0.0-beta.2 | HTML content rendering |
| `dropdown_button2` | ^2.3.9 | Enhanced dropdowns |
| `sticky_headers` | ^0.3.0+2 | Sticky list headers |
| `url_launcher` | ^6.1.14 | External URL opening |
| `fluttertoast` | ^8.2.2 | Toast messages |
| `package_info_plus` | ^4.1.0 | App version info |
| `intl` | ^0.18.1 | Internationalization |

### Dev Dependencies

| Package | Purpose |
|---|---|
| `flutter_lints` | Lint rules |
| `flutter_test` | Testing framework |
