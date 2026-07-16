# LDCE Alumni App v2 — New App Setup & Development Guide for AI Agents

> **This document is the single source of truth for any AI agent building the new LDCE Alumni Flutter app.**  
> **Read this ENTIRELY before writing any code.**

---

## Table of Contents

1. [Project Context](#1-project-context)
2. [Architecture: MVC + Provider](#2-architecture-mvc--provider)
3. [Folder Structure (New App)](#3-folder-structure-new-app)
4. [Dependency List](#4-dependency-list)
5. [Environment Configuration](#5-environment-configuration)
6. [App Entry Point Specification](#6-app-entry-point-specification)
7. [Routing Strategy](#7-routing-strategy)
8. [Base Classes & Contracts](#8-base-classes--contracts)
9. [Network Layer Specification](#9-network-layer-specification)
10. [Model Layer Specification](#10-model-layer-specification)
11. [Controller Layer Specification](#11-controller-layer-specification)
12. [View Layer Specification](#12-view-layer-specification)
13. [Feature Module Specifications](#13-feature-module-specifications)
14. [Authentication Specification](#14-authentication-specification)
15. [Firebase & Push Notifications](#15-firebase--push-notifications)
16. [Theme System Specification](#16-theme-system-specification)
17. [Error Handling Strategy](#17-error-handling-strategy)
18. [Shared Widgets Library](#18-shared-widgets-library)
19. [Localization Strategy](#19-localization-strategy)
20. [Testing Strategy](#20-testing-strategy)
21. [Coding Standards](#21-coding-standards)
22. [API Reference (Complete)](#22-api-reference-complete)
23. [Implementation Order](#23-implementation-order)

---

## 1. Project Context

We are rebuilding the LDCE Alumni mobile app from scratch. The original app was built 4 years ago and has significant tech debt.

**What stays the same:**
- Same backend REST API (`http://api.ldcealumni.net/api/`)
- Same features: News, Events, Media, Noteworthy, Alumni Directory, Digital Downloads, Projects, Profile, Auth
- Same API response format: `{ "Status": bool, "Message": string, "Result": [...] | {...} }`
- Flutter framework, Provider state management

**What changes:**
- Clean MVC architecture with proper separation of concerns
- Repository pattern for API calls (models are pure data classes)
- Proper dependency injection
- Environment-based configuration (dev/staging/prod)
- Structured error handling with Result type
- Type-safe routing with GoRouter
- Proper null safety throughout
- Comprehensive testing
- No global mutable state
- No commented-out code, no dead files
- Production-quality code from day one

---

## 2. Architecture: MVC + Provider

```
┌──────────────────────────────────────────────────────────────────┐
│                         VIEW LAYER                               │
│  Screens (pages) + Reusable Widgets                             │
│  • Consumes controllers via Provider Consumer/Selector          │
│  • ZERO business logic. Only UI rendering + user interaction.    │
│  • Calls controller methods for actions.                         │
└──────────────────┬───────────────────────────────────────────────┘
                   │
                   │ Provider (Consumer<XController>)
                   │
┌──────────────────▼───────────────────────────────────────────────┐
│                     CONTROLLER LAYER                             │
│  ChangeNotifier classes (one per feature module)                 │
│  • Manages feature state (loading, data, error, pagination)      │
│  • Calls Repository methods for data operations                  │
│  • NEVER does HTTP calls directly                                │
│  • NEVER imports dart:io or http package                         │
│  • notifyListeners() after state changes                         │
└──────────────────┬───────────────────────────────────────────────┘
                   │
                   │ Method calls
                   │
┌──────────────────▼───────────────────────────────────────────────┐
│                     REPOSITORY LAYER (Services)                  │
│  API Repositories (one per API resource group)                   │
│  • Handles all HTTP communication                                │
│  • Request building, header injection, error mapping             │
│  • Returns typed Result<T> (success/failure)                     │
│  • Uses ApiClient for actual HTTP calls                          │
│  • JSON parsing → Model objects                                  │
└──────────────────┬───────────────────────────────────────────────┘
                   │
                   │ Uses
                   │
┌──────────────────▼───────────────────────────────────────────────┐
│                       MODEL LAYER                                │
│  Pure data classes (immutable where possible)                    │
│  • No API logic, no HTTP, no business logic                      │
│  • factory fromJson(Map<String, dynamic> json)                   │
│  • Map<String, dynamic> toJson()                                 │
│  • copyWith() for immutable updates                              │
│  • == and hashCode overrides                                     │
└──────────────────────────────────────────────────────────────────┘
```

### Key Principles
1. **Models are PURE data** — No static API methods. No imports beyond `dart:core`.
2. **Repositories own all network I/O** — One repository per API resource group.
3. **Controllers manage feature state** — Loading, error, data, pagination. Call repositories.
4. **Views render state** — Use `Consumer`/`Selector` to read controller state. Call controller methods.
5. **No global mutable state** — Everything flows through Provider.

---

## 3. Folder Structure (New App)

```
lib/
├── main.dart                              # Entry point
├── app.dart                               # MaterialApp configuration
│
├── config/
│   ├── app_config.dart                    # Environment config (dev/staging/prod)
│   ├── routes.dart                        # GoRouter route definitions
│   └── provider_config.dart               # All ChangeNotifierProvider registrations
│
├── core/
│   ├── constants/
│   │   ├── api_constants.dart             # API endpoint paths (NO base URL)
│   │   ├── app_constants.dart             # App-wide constants (timeouts, page sizes)
│   │   ├── asset_constants.dart           # Asset path constants
│   │   └── string_constants.dart          # UI string keys (for localization ref)
│   ├── enums/
│   │   ├── load_state.dart               # enum LoadState { initial, loading, loaded, error }
│   │   ├── download_category.dart        # enum DownloadCategory { ... }
│   │   └── gender.dart                   # enum Gender { male, female, other }
│   ├── errors/
│   │   ├── app_exception.dart            # Custom exception classes
│   │   ├── failure.dart                  # Failure sealed class for error handling
│   │   └── error_handler.dart            # Maps exceptions to user-friendly messages
│   ├── network/
│   │   ├── api_client.dart               # HTTP client wrapper (get, post, put, delete)
│   │   ├── api_response.dart             # Generic ApiResponse<T> class
│   │   ├── network_info.dart             # Connectivity checker (replaces globals.checkInternet)
│   │   └── interceptors/
│   │       └── auth_interceptor.dart     # Injects Bearer token into requests
│   ├── storage/
│   │   ├── secure_storage_service.dart   # FlutterSecureStorage wrapper
│   │   └── storage_keys.dart             # Storage key constants
│   └── utils/
│       ├── date_utils.dart               # Date formatting helpers
│       ├── validators.dart               # Form validation functions
│       ├── debouncer.dart                # Search debounce utility
│       └── logger.dart                   # Structured logging wrapper
│
├── models/
│   ├── alumni.dart                        # Alumni data class
│   ├── auth_token.dart                    # Auth token data class
│   ├── digital_download.dart              # Digital download data class
│   ├── event.dart                         # Event data class
│   ├── home_slider.dart                   # Slider image data class
│   ├── media.dart                         # Media data class
│   ├── membership_type.dart               # Membership type data class
│   ├── news.dart                          # News data class
│   ├── noteworthy.dart                    # Noteworthy data class
│   ├── profile.dart                       # Profile data class
│   ├── update_profile_request.dart        # Profile update request body
│   └── masters/
│       ├── branch.dart                    # Branch dropdown item
│       ├── city.dart                      # City dropdown item
│       ├── country.dart                   # Country dropdown item
│       ├── program.dart                   # Program dropdown item
│       └── l_state.dart                   # State dropdown item (avoid Dart keyword)
│
├── repositories/
│   ├── auth_repository.dart               # Login, getEncId
│   ├── alumni_repository.dart             # Alumni directory, search
│   ├── event_repository.dart              # Events CRUD
│   ├── news_repository.dart               # News CRUD
│   ├── media_repository.dart              # Media gallery
│   ├── noteworthy_repository.dart         # Noteworthy/achievements
│   ├── digital_download_repository.dart   # Digital downloads (all categories)
│   ├── home_repository.dart               # Slider data
│   ├── profile_repository.dart            # Profile get/update, image upload
│   └── master_repository.dart             # Countries, states, cities, programs, branches, membership types
│
├── controllers/
│   ├── auth_controller.dart
│   ├── home_controller.dart
│   ├── news_controller.dart
│   ├── event_controller.dart
│   ├── media_controller.dart
│   ├── noteworthy_controller.dart
│   ├── alumni_controller.dart
│   ├── digital_download_controller.dart
│   ├── profile_controller.dart
│   └── theme_controller.dart              # (replaces AppNotifier)
│
├── views/
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── auth/
│   │   └── login_screen.dart
│   ├── home/
│   │   ├── home_screen.dart               # Main scaffold with bottom nav/tabs
│   │   ├── tabs/
│   │   │   ├── home_tab.dart              # Welcome/about content
│   │   │   ├── news_tab.dart              # Latest news preview
│   │   │   ├── events_tab.dart            # Latest event preview
│   │   │   ├── media_tab.dart             # Latest media preview
│   │   │   ├── noteworthy_tab.dart        # Latest noteworthy preview
│   │   │   ├── downloads_tab.dart         # Latest download preview
│   │   │   └── projects_tab.dart          # Projects list
│   │   └── widgets/
│   │       └── home_carousel.dart         # Carousel slider widget
│   ├── news/
│   │   ├── news_list_screen.dart
│   │   └── news_detail_screen.dart
│   ├── events/
│   │   ├── event_list_screen.dart         # Tabs: upcoming/past
│   │   └── event_detail_screen.dart
│   ├── media/
│   │   ├── media_list_screen.dart
│   │   └── media_detail_screen.dart
│   ├── noteworthy/
│   │   ├── noteworthy_list_screen.dart
│   │   └── noteworthy_detail_screen.dart
│   ├── alumni/
│   │   └── alumni_directory_screen.dart
│   ├── downloads/
│   │   ├── downloads_screen.dart          # 5-tab categories
│   │   └── download_detail_screen.dart
│   ├── projects/
│   │   ├── tree_plantation_screen.dart
│   │   └── at_hackathon_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   ├── general/
│   │   ├── about_screen.dart
│   │   └── membership_types_screen.dart
│   └── error/
│       ├── no_internet_screen.dart
│       └── error_screen.dart
│
├── views/widgets/                         # SHARED reusable widgets
│   ├── app_scaffold.dart                  # Standard scaffold with appbar + drawer
│   ├── custom_app_bar.dart                # Branded AppBar
│   ├── app_drawer.dart                    # Navigation drawer
│   ├── content_card.dart                  # Generic card (image + title + desc)
│   ├── news_card.dart                     # News-specific card
│   ├── event_card.dart                    # Event-specific card
│   ├── alumni_card.dart                   # Alumni expansion card
│   ├── download_card.dart                 # Download item card
│   ├── image_gallery.dart                 # PageView gallery + thumbnails
│   ├── full_image_viewer.dart             # Full-screen zoomable image
│   ├── loading_shimmer.dart               # Shimmer skeleton loading
│   ├── error_widget.dart                  # Inline error with retry
│   ├── empty_state_widget.dart            # Empty list state
│   ├── pagination_loader.dart             # Infinite scroll loader indicator
│   ├── section_header.dart                # Section title with "View All" button
│   ├── html_content.dart                  # flutter_html wrapper
│   ├── cached_image.dart                  # CachedNetworkImage wrapper
│   └── custom_dropdown.dart               # Styled dropdown
│
├── extensions/
│   ├── build_context_extensions.dart      # Theme, MediaQuery shortcuts
│   ├── string_extensions.dart
│   ├── date_extensions.dart
│   └── widget_extensions.dart             # Padding, margin, etc.
│
├── theme/
│   ├── app_colors.dart                    # Color palette constants
│   ├── app_text_styles.dart               # TextStyle presets
│   ├── app_theme.dart                     # ThemeData builder (light + dark)
│   └── app_spacing.dart                   # Spacing/padding constants
│
└── l10n/
    ├── app_en.arb                         # English translations
    ├── app_hi.arb                         # Hindi translations
    ├── app_ar.arb                         # Arabic translations
    ├── app_fr.arb                         # French translations
    └── app_zh.arb                         # Chinese translations
```

---

## 4. Dependency List

```yaml
# pubspec.yaml
name: ldce_alumni
description: LDCE Alumni Connect - Official App
publish_to: 'none'
version: 2.0.0+1

environment:
  sdk: ">=3.2.0 <4.0.0"
  flutter: ">=3.19.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State Management
  provider: ^6.1.2

  # Routing
  go_router: ^14.0.0

  # Network
  http: ^1.2.1
  connectivity_plus: ^6.0.0

  # Firebase
  firebase_core: ^3.0.0
  firebase_messaging: ^15.0.0

  # Storage
  flutter_secure_storage: ^9.2.0
  shared_preferences: ^2.2.3

  # UI Components
  cached_network_image: ^3.3.1
  carousel_slider: ^5.0.0
  shimmer: ^3.0.0
  flutter_html: ^3.0.0-beta.2
  google_fonts: ^6.2.1
  dropdown_button2: ^2.3.9
  fluttertoast: ^8.2.4
  material_design_icons_flutter: ^7.0.7296

  # Image
  image_picker: ^1.0.7

  # Utilities
  intl: ^0.19.0
  url_launcher: ^6.2.5
  package_info_plus: ^8.0.0
  path_provider: ^2.1.3
  flutter_native_splash: ^2.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  mockito: ^5.4.4
  build_runner: ^2.4.9

flutter:
  uses-material-design: true
  generate: true  # For l10n

  assets:
    - assets/images/
    - assets/images/banners/
    - assets/icons/

  fonts:
    - family: Montserrat
      fonts:
        - asset: assets/fonts/montserrat.ttf
    - family: CustomBadge
      fonts:
        - asset: assets/fonts/CustomBadge.ttf
```

---

## 5. Environment Configuration

```dart
// lib/config/app_config.dart

enum Environment { dev, staging, prod }

class AppConfig {
  final Environment environment;
  final String baseApiUrl;
  final String appName;
  final int apiTimeoutSeconds;
  final int defaultPageSize;

  const AppConfig._({
    required this.environment,
    required this.baseApiUrl,
    required this.appName,
    required this.apiTimeoutSeconds,
    required this.defaultPageSize,
  });

  static const dev = AppConfig._(
    environment: Environment.dev,
    baseApiUrl: 'https://ldcealumniapi.devitsandbox.com/api',
    appName: 'LDCE Connect (Dev)',
    apiTimeoutSeconds: 40,
    defaultPageSize: 10,
  );

  static const staging = AppConfig._(
    environment: Environment.staging,
    baseApiUrl: 'https://ldcealumniapi.devitsandbox.com/api',
    appName: 'LDCE Connect (Staging)',
    apiTimeoutSeconds: 40,
    defaultPageSize: 10,
  );

  static const prod = AppConfig._(
    environment: Environment.prod,
    baseApiUrl: 'http://api.ldcealumni.net/api',
    appName: 'LDCE Connect',
    apiTimeoutSeconds: 40,
    defaultPageSize: 10,
  );
}
```

---

## 6. App Entry Point Specification

### `main.dart`
```dart
// 1. WidgetsFlutterBinding.ensureInitialized()
// 2. Firebase.initializeApp()
// 3. Set up FCM background handler
// 4. Request notification permissions
// 5. Subscribe to FCM topics based on platform and build mode
// 6. Lock orientation to portrait
// 7. Initialize AppConfig (prod by default, dev in debug mode)
// 8. Initialize SecureStorageService
// 9. Initialize ApiClient with config
// 10. Initialize all repositories (passing ApiClient)
// 11. runApp(ProviderConfig.wrap(App()))
```

### `app.dart`
```dart
// MaterialApp.router(
//   routerConfig: AppRouter.router,
//   theme: AppTheme.light,
//   darkTheme: AppTheme.dark,
//   themeMode: themeController.themeMode,
//   localizationsDelegates: [...],
//   supportedLocales: [...],
//   debugShowCheckedModeBanner: false,
// )
```

---

## 7. Routing Strategy

Use **GoRouter** for type-safe, declarative routing.

```dart
// lib/config/routes.dart

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const profile = '/profile';
  static const newsList = '/news';
  static const newsDetail = '/news/:id';       // pathParam id
  static const eventsList = '/events';
  static const eventDetail = '/events/:id';
  static const mediaList = '/media';
  static const mediaDetail = '/media/:id';
  static const noteworthyList = '/noteworthy';
  static const noteworthyDetail = '/noteworthy/:id';
  static const alumniDirectory = '/alumni-directory';
  static const downloads = '/downloads';
  static const downloadDetail = '/downloads/:id';
  static const treePlantation = '/projects/tree-plantation';
  static const atHackathon = '/projects/at-hackathon';
  static const about = '/about';
  static const membershipTypes = '/membership-types';
  static const noInternet = '/no-internet';
  static const error = '/error';
}

// GoRouter config:
// - initialLocation: AppRoutes.splash
// - Splash → check auth → redirect to home
// - Profile route: requires auth (redirect to login if no token)
// - Error route: onException handler
// - Deep link support for FCM notifications: /news/:id, /events/:id
```

---

## 8. Base Classes & Contracts

### LoadState Enum
```dart
enum LoadState { initial, loading, loaded, error, loadingMore }
```

### ApiResponse<T>
```dart
// Wraps all API responses. Parses the standard { Status, Message, Result } envelope.
class ApiResponse<T> {
  final bool status;
  final String message;
  final T? result;
  // factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromResult)
}
```

### Result<T> (for repository returns)
```dart
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);
}
```

### AppException
```dart
sealed class AppException implements Exception {
  final String message;
  final int? statusCode;
  const AppException(this.message, [this.statusCode]);
}
class NetworkException extends AppException { ... }
class ServerException extends AppException { ... }
class UnauthorizedException extends AppException { ... }
class TimeoutException extends AppException { ... }
class UnknownException extends AppException { ... }
```

### BaseController pattern
```dart
// Every controller should follow this pattern:
abstract class FeatureController extends ChangeNotifier {
  LoadState _state = LoadState.initial;
  LoadState get state => _state;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  void setState(LoadState state) {
    _state = state;
    notifyListeners();
  }
  
  void setError(String message) {
    _errorMessage = message;
    _state = LoadState.error;
    notifyListeners();
  }
}
```

---

## 9. Network Layer Specification

### ApiClient
```dart
// lib/core/network/api_client.dart
// 
// Responsibilities:
// - Wraps http package
// - Accepts AppConfig for baseUrl and timeout
// - Methods: get(), post(), put(), delete()
// - Auto-injects Content-Type: application/json
// - Injects Bearer token from SecureStorageService if available
// - Throws typed AppException on failures:
//     - SocketException → NetworkException
//     - TimeoutException → TimeoutException  
//     - 401 → UnauthorizedException
//     - 500+ → ServerException
//     - Other → UnknownException
// - Logs requests/responses in debug mode
//
// Signature:
// Future<http.Response> get(String path, {Map<String, String>? queryParams, bool auth = false})
// Future<http.Response> post(String path, {dynamic body, bool auth = false, String? contentType})
// Future<http.Response> put(String path, {dynamic body, bool auth = false})
```

### NetworkInfo
```dart
// lib/core/network/network_info.dart
// Uses connectivity_plus to check connectivity (replaces google.com ping hack)
// Future<bool> get isConnected
```

---

## 10. Model Layer Specification

Every model MUST follow this template:

```dart
class ModelName {
  final Type field1;
  final Type field2;
  // ...

  const ModelName({
    required this.field1,
    required this.field2,
  });

  factory ModelName.fromJson(Map<String, dynamic> json) {
    return ModelName(
      field1: json['ApiFieldName'] as Type ?? defaultValue,
      field2: json['ApiFieldName2'] as Type ?? defaultValue,
    );
  }

  Map<String, dynamic> toJson() => {
    'ApiFieldName': field1,
    'ApiFieldName2': field2,
  };

  ModelName copyWith({Type? field1, Type? field2}) {
    return ModelName(
      field1: field1 ?? this.field1,
      field2: field2 ?? this.field2,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || 
    other is ModelName && field1 == other.field1 && field2 == other.field2;

  @override
  int get hashCode => Object.hash(field1, field2);
}
```

### All Models to Create

#### `alumni.dart`
```
Fields: name (String), passoutYear (String), program (String), branch (String), membership (String), profession (String)
JSON mapping: FullName, PassoutYear, Program, Branch, Membership, CompanyName
```

#### `auth_token.dart`
```
Fields: accessToken (String), tokenType (String), expiresIn (int)
JSON mapping: access_token, token_type, expires_in
```

#### `event.dart`
```
Fields: id (String?), coverPhoto (String), startDate (DateTime), endDate (DateTime), title (String), shortDescription (String), description (String), venue (String), contactPerson (String), attachments (List<String>)
JSON mapping: Id, CoverPhotoPath, StartDate, EndDate, Title, Description, HtmlContent, Venue, ContactPerson, Attachement[].Path
Note: Parse StartDate/EndDate as DateTime, not String
```

#### `news.dart`
```
Fields: id (String?), imageUrl (String), date (DateTime), title (String), shortDescription (String), description (String), attachments (List<String>)
JSON mapping: Id, CoverPhotoPath, CreatedOn, Title, Description, HtmlContent, Attachement[].Path
```

#### `media.dart`
```
Fields: id (String?), coverPhoto (String), date (DateTime), title (String), shortDescription (String), description (String), images (List<String>)
JSON mapping: Id, CoverPhotoPath, CreatedOn, Title, Description, HtmlContent, Attachement (List)
Note: images = Attachement list mapped to paths
```

#### `noteworthy.dart`
```
Fields: id (String?), coverPhoto (String), title (String), shortDescription (String), description (String), alumniName (String), alumniBranch (String), alumniPassoutYear (String)
JSON mapping: Id, CoverPhotoPath, Title, Description, HtmlContent, AlumniName, AlumniBranch, AlumniPassoutYear
```

#### `digital_download.dart`
```
Fields: id (String?), title (String), description (String), category (String), fileUrl (String), pdfFileUrl (String)
JSON mapping: Id, Title, Description, CategoryType, FileName, PDFFileName
```

#### `home_slider.dart`
```
Fields: imageUrl (String)
JSON mapping: Direct string from Result array (not an object)
Custom fromJson: factory HomeSlider.fromJson(String url) => HomeSlider(imageUrl: url);
```

#### `profile.dart`
```
Fields (34 total): encryptedId, firstName, middleName, lastName, fullName, gender (bool), dob, countryId, stateId, cityId, countryName, stateName, cityName, profilePicPath, primaryAddress, secondaryAddress, emailAddress, pinCode, mobileNo, telephoneNo, companyName, companyAddress, designation, passoutYear, streamId, degreeId, streamName, degreeName, membershipTypeId, membership, isMembershipVerified, isEligibleForChangeMembership, isChangeMembershipRequestSent, requestStatus
JSON mapping: EncryptedId, FirstName, MiddleName, LastName, FullName, Gender, DOB, CountryId, StateId, CityId, CountryName, StateName, CityName, ProfilePicPath, PrimaryAddress, SecondaryAddress, EmailAddress, PinCode, MobileNo, TelephoneNo, CompanyName, CompanyAddress, Designation, PassoutYear, StreamId, DegreeId, StreamName, DegreeName, MembershipTypeId, Membership, IsMembershipVerified, IsEligibleForChangeMembership, IsChangeMembershipRequestSent, RequestStatus
```

#### `update_profile_request.dart`
```
A toJson()-only model used as the POST body for profile update.
Fields mirror profile but as mutable request payload.
```

#### `membership_type.dart`
```
Fields: id (int), name (String), extraName (String), fees (int), sequence (int)
JSON mapping: Id, Name, ExtraName, Fees, Sequence
```

#### Masters: `branch.dart`, `city.dart`, `country.dart`, `program.dart`, `l_state.dart`
```
All follow same pattern:
Fields: id (int), name (String)
JSON mapping: Id, Name
Keep it simple — lightweight dropdown items only.
```

---

## 11. Controller Layer Specification

Every controller MUST:
1. Extend `ChangeNotifier`
2. Track `LoadState` for primary data and `LoadState` for "load more" (pagination)
3. Store data in typed lists/objects
4. Have `init()` or `fetch()` method called on creation
5. Have `loadMore(int page)` for paginated features
6. Store `currentPage` as int for pagination tracking
7. Store `hasMore` as bool — set to false when API returns < pageSize items
8. Handle errors by setting error state with message
9. NEVER import `dart:io` or `package:http`
10. Only call Repository methods

### Controller Specifications

#### `AuthController`
```
State: LoadState loginState, AuthToken? token
Methods: 
  - login(String email, String password) → calls AuthRepository.login(), stores token, calls storeEncId()
  - logout() → clears secure storage, resets state
  - storeEncId() → calls AuthRepository.getEncId(), stores in secure storage
  - isLoggedIn → bool (checks secure storage for token)
```

#### `HomeController`
```
State: 
  LoadState sliderState, List<HomeSlider> sliders
  LoadState newsPreviewState, News? latestNews
  LoadState eventPreviewState, Event? latestEvent
  LoadState mediaPreviewState, Media? latestMedia
  LoadState noteworthyPreviewState, Noteworthy? latestNoteworthy
  LoadState downloadPreviewState, DigitalDownload? latestDownload
Methods:
  - fetchSliders() → HomeRepository.getSliders()
  - fetchNewsPreview() → NewsRepository.getNews(pageSize: 1, pageNumber: 1)
  - fetchEventPreview() → EventRepository.getEvents(pageSize: 1, pageNumber: 1)
  - fetchMediaPreview() → MediaRepository.getMedia(pageSize: 1, pageNumber: 1)
  - fetchNoteworthyPreview() → NoteworthyRepository.getNoteworthy(pageSize: 1, pageNumber: 1)
  - fetchDownloadPreview() → DigitalDownloadRepository.getDesktopWallpapers(pageSize: 1, pageNumber: 1)
  - fetchAll() → calls all above
```

#### `NewsController`
```
State: LoadState state, List<News> newsList, News? selectedNews, int currentPage, bool hasMore
Methods:
  - fetchNews() → NewsRepository.getNews(pageSize, pageNumber: 1)
  - loadMore() → NewsRepository.getNews(pageSize, pageNumber: ++currentPage)
  - fetchSingleNews(String id) → NewsRepository.getNewsById(id)
```

#### `EventController`
```
State: 
  LoadState state
  List<Event> upcomingEvents, List<Event> pastEvents
  Event? selectedEvent
  int upcomingPage, int pastPage
  bool hasMoreUpcoming, bool hasMorePast
Methods:
  - fetchEvents() → EventRepository.getEvents() → split by startDate vs now
  - loadMoreUpcoming() → paginate upcoming
  - loadMorePast() → paginate past
  - fetchSingleEvent(String id) → EventRepository.getEventById(id)
```

#### `MediaController`
```
State: LoadState state, List<Media> mediaList, int currentPage, bool hasMore
Methods:
  - fetchMedia() → MediaRepository.getMedia()
  - loadMore() → paginate
```

#### `NoteworthyController`
```
State: LoadState state, List<Noteworthy> noteworthyList, int currentPage, bool hasMore
Methods:
  - fetchNoteworthy() → NoteworthyRepository.getNoteworthy()
  - loadMore() → paginate
```

#### `AlumniController`
```
State: 
  LoadState state
  List<Alumni> alumniList
  int currentPage, bool hasMore
  String? searchName, searchYear, searchDegree, searchBranch, searchMembershipType
Methods:
  - fetchAlumni() → AlumniRepository.getAlumni()
  - searchAlumni({name, year, degree, branch, membershipType}) → AlumniRepository.searchAlumni(...)
  - loadMore() → paginate (for both list and search)
  - clearSearch() → reset filters
```

#### `DigitalDownloadController`
```
State:
  Map<DownloadCategory, LoadState> categoryStates
  Map<DownloadCategory, List<DigitalDownload>> categoryData
  Map<DownloadCategory, int> categoryPages
  Map<DownloadCategory, bool> categoryHasMore
  DigitalDownload? selectedDownload
Methods:
  - fetchCategory(DownloadCategory category) → DigitalDownloadRepository.getByCategory(category)
  - loadMore(DownloadCategory category) → paginate
  - fetchSingleDownload(String id) → DigitalDownloadRepository.getById(id)
  - fetchAll() → fetches all 5 categories
```

#### `ProfileController`
```
State:
  LoadState profileState, LoadState updateState, LoadState masterDataState
  Profile? profile
  bool isEditMode
  List<Country> countries, List<LState> states, List<City> cities
  List<Program> programs, List<Branch> branches, List<MembershipType> membershipTypes
  Country? selectedCountry, LState? selectedState, City? selectedCity
  Program? selectedProgram, Branch? selectedBranch
  // All TextEditingControllers for form fields
Methods:
  - fetchProfile() → ProfileRepository.getProfile()
  - updateProfile() → builds UpdateProfileRequest from form → ProfileRepository.updateProfile()
  - loadMasterData() → MasterRepository.getCountries(), .getPrograms(), .getBranches(), .getMembershipTypes()
  - onCountryChanged(Country) → MasterRepository.getStates(countryId)
  - onStateChanged(LState) → MasterRepository.getCities(stateId)
  - toggleEditMode()
  - uploadProfileImage(File) → ProfileRepository.uploadImage()
  - updateMembershipType(int id) → MasterRepository.updateMembershipType()
```

#### `ThemeController`
```
State: ThemeMode themeMode, Locale locale
Methods:
  - toggleTheme() → switches light/dark
  - setLocale(Locale) → changes app language
```

---

## 12. View Layer Specification

### View Rules
1. Every screen is a `StatelessWidget` (prefer) or `StatefulWidget` (when needed for TabController, ScrollController, animations)
2. Screens consume controllers via `Consumer<XController>` or `context.watch<XController>()`
3. Screens render based on `controller.state` using a switch:
   ```dart
   switch (controller.state) {
     case LoadState.initial:
     case LoadState.loading:
       return LoadingShimmer();
     case LoadState.error:
       return ErrorWidget(message: controller.errorMessage, onRetry: controller.fetch);
     case LoadState.loaded:
     case LoadState.loadingMore:
       return _buildContent(controller);
   }
   ```
4. Use `AppScaffold` for consistent layout (AppBar + Drawer)
5. Infinite scroll: attach `ScrollController` with `_onScroll()` that calls `controller.loadMore()` when near bottom
6. Navigate via `context.go()` or `context.push()` (GoRouter)

### Screen Specifications

| Screen | Consumer | Layout | Key Widgets |
|---|---|---|---|
| SplashScreen | AuthController | Centered logo + loading | Auto-navigate after init |
| LoginScreen | AuthController | Form (email + password) | TextFormField, ElevatedButton |
| HomeScreen | HomeController | Scaffold + TabBarView (7 tabs) + CarouselSlider | HomeCarousel, Tab widgets |
| NewsListScreen | NewsController | ListView + infinite scroll | NewsCard, PaginationLoader |
| NewsDetailScreen | NewsController | ScrollView with details | ImageGallery, HtmlContent |
| EventListScreen | EventController | TabBarView (upcoming/past) + infinite scroll | EventCard, PaginationLoader |
| EventDetailScreen | EventController | ScrollView with details | ImageGallery, HtmlContent |
| MediaListScreen | MediaController | ListView + infinite scroll | ContentCard, PaginationLoader |
| MediaDetailScreen | MediaController | ScrollView with gallery | ImageGallery, HtmlContent |
| NoteworthyListScreen | NoteworthyController | ListView + infinite scroll | AlumniCard |
| NoteworthyDetailScreen | NoteworthyController | ScrollView details | CachedImage, HtmlContent |
| AlumniDirectoryScreen | AlumniController | Search + filters + paginated list | CustomDropdown, AlumniCard |
| DownloadsScreen | DigitalDownloadController | TabBarView (5 tabs) | DownloadCard |
| DownloadDetailScreen | DigitalDownloadController | Detail view | CachedImage |
| ProfileScreen | ProfileController | Sectioned form (4 sections) | TextFormField, CustomDropdown, ImagePicker |
| TreePlantationScreen | None | Static content | CachedImage, url_launcher |
| AtHackathonScreen | None | Static content | CachedImage, url_launcher |
| AboutScreen | None | Static content | Text |
| MembershipTypesScreen | None | Static content | Text, url_launcher |
| NoInternetScreen | None | Error + retry | Icon, ElevatedButton |
| ErrorScreen | None | Error + retry | Icon, ElevatedButton |

---

## 13. Feature Module Specifications

### Home Module
- **Home Screen** is the root. Contains:
  - `CarouselSlider` of banners from API `/Slider`
  - `TabBar` with 7 tabs: Home, News, Events, Media, Noteworthy, Projects, Downloads
  - Each tab shows a PREVIEW (1 item) with "View All" button
  - Bottom: "ALUMNI DIRECTORY" banner linking to directory
- **Firebase Notification Handling** in HomeScreen:
  - `getInitialMessage()` for app launch from notification
  - `onMessageOpenedApp` for background tap
  - Route to news/event detail based on notification data

### Alumni Directory Module
- Search bar + 4 filter dropdowns (Program, Branch, Year, Membership Type)
- Programs: B.E., M.E., MCA
- Branches: 15 for B.E., 19 for M.E., varies
- Years: 1951–current year + 2
- Results as expansion tiles
- Previous/Next page buttons (NOT infinite scroll — keep original UX)

### Profile Module
- 4 form sections: Personal, Academic, Contact, Company
- Cascading dropdowns: Country → (loads states) → State → (loads cities) → City
- Year picker dialog for passout year
- Profile picture upload (max 5MB, image_picker + multipart POST)
- Edit/View toggle mode

---

## 14. Authentication Specification

```
Flow:
1. LoginScreen → user enters email + password
2. AuthController.login(email, password)
3. AuthRepository.login(email, password) →
   POST /Login
   Content-Type: application/x-www-form-urlencoded
   Body: grant_type=password&username={email}&password={password}&remember=true
4. Returns AuthToken (access_token, token_type, expires_in)
5. Store access_token in SecureStorage with key 'access_token'
6. AuthRepository.getEncId() →
   GET /Alumni/GetId
   Headers: Authorization: Bearer {access_token}
7. Store encId in SecureStorage with key 'encId'
8. Navigate to HomeScreen

Logout:
1. Clear all SecureStorage
2. Reset AuthController state
3. Navigate to HomeScreen

Auth Guard:
- Profile route requires auth token
- If no token, redirect to LoginScreen
- AppBarWidget shows profile pic when logged in, login icon when not
- Drawer shows "Profile" when logged in, "Login" when not
```

---

## 15. Firebase & Push Notifications

```
Setup:
1. Firebase.initializeApp() in main.dart
2. Background handler: @pragma('vm:entry-point') at top level
3. Request permissions (alert, badge, sound)
4. Subscribe to FCM topics:
   - 'all-android' or 'all-ios' (platform-based)
   - Debug-only topics in kDebugMode
5. Foreground presentation options: alert=true, badge=true, sound=true

Handling:
1. App terminated → getInitialMessage():
   - Parse data['type'] and data['id']
   - If type contains 'news' → navigate to /news/{id}
   - If type contains 'event' → navigate to /events/{id}
2. App in background → onMessageOpenedApp:
   - Same routing logic
3. App in foreground → onMessage:
   - Show in-app notification banner (optional enhancement)
```

---

## 16. Theme System Specification

```dart
// lib/theme/app_colors.dart
class AppColors {
  // Primary
  static const primary = Color(0xff3C4EC5);
  static const primaryDark = Color(0xff069DEF);
  static const accent = Color(0xffFF5252);
  
  // Background
  static const scaffoldLight = Color(0xffffffff);
  static const scaffoldDark = Color(0xff161616);
  static const cardLight = Color(0xfff0f0f0);
  static const cardDark = Color(0xff222327);
  
  // Text
  static const textPrimary = Color(0xff495057);
  static const textSecondary = Color(0xff6c757d);
  
  // Status
  static const success = Color(0xff28a745);
  static const error = Color(0xffdc3545);
  static const warning = Color(0xffffc107);
  
  // LDCE Brand
  static const ldceRed = Color(0xffCC0000);
  static const ldceNavy = Color(0xff021048);
}

// lib/theme/app_theme.dart
// Build ThemeData for both light and dark modes
// Font: Montserrat (primary), GoogleFonts.montserrat (fallback)
// Include theming for: AppBar, Card, TabBar, Checkbox, Radio, Switch, FAB, Divider, BottomAppBar
```

---

## 17. Error Handling Strategy

```
Network errors:
  SocketException → "No internet connection. Please check your network."
  TimeoutException → "Request timed out. Please try again."
  401 Unauthorized → "Session expired. Please login again." → redirect to login
  500+ Server Error → "Something went wrong. Please try again later."
  Other → "An unexpected error occurred."

UI error handling:
  - Every screen handles LoadState.error with an ErrorWidget showing message + retry button
  - SnackBar for non-critical errors (form validation, upload failures)
  - Full-screen error page for navigation failures
  - NoInternetScreen for connectivity issues

Controller error handling:
  - Every async operation wrapped in try/catch
  - Repository returns Result<T> (Success/Failure)
  - Controller inspects Result and sets state accordingly
```

---

## 18. Shared Widgets Library

### Required Shared Widgets

1. **`AppScaffold`** — Standard `Scaffold` with `CustomAppBar` and `AppDrawer`. Accepts `title`, `body`, `floatingActionButton`, `showProfile`, `bottom`.

2. **`CustomAppBar`** — `PreferredSizeWidget`. Logo + "LDCE Connect" (tapping goes home). Profile avatar (if logged in) + hamburger menu. Matches original design (semi-transparent black bg).

3. **`AppDrawer`** — Full navigation drawer. Dynamic: shows Profile/Login based on auth. Shows all navigation items. Shows app version from package_info_plus. Logout option when logged in.

4. **`ContentCard`** — Reusable card: `CachedImage` on top, title, description below. Used for media, news (home preview), downloads.

5. **`NewsCard`** — News-specific card with date, title, description, cover image.

6. **`EventCard`** — Event card with dates, title, venue.

7. **`AlumniCard`** — ExpansionTile with alumni name, year, program, branch, membership, profession.

8. **`DownloadCard`** — Download item with title, category badge, preview image.

9. **`ImageGallery`** — `PageView` with images + horizontal thumbnail strip below. Selected thumbnail highlighted. Tapping image opens `FullImageViewer`. Used on detail screens for news, events, media.

10. **`FullImageViewer`** — Full-screen overlay. Semi-transparent background. Pinch-to-zoom. Tap to close. `Hero` animation with image tag.

11. **`LoadingShimmer`** — Shimmer effect placeholder matching the layout of the screen it replaces. Should have variants: `ShimmerList`, `ShimmerCard`, `ShimmerDetail`.

12. **`AppErrorWidget`** — Centered icon + message + "Retry" button. Used inline (not full-screen).

13. **`EmptyStateWidget`** — Centered icon + "No data found" message. Used when list is empty after loading.

14. **`PaginationLoader`** — `CircularProgressIndicator` at bottom of list during loadMore.

15. **`SectionHeader`** — Section title (left) + "View All >" button (right). Used on home tabs.

16. **`HtmlContent`** — Wraps `flutter_html`'s `Html` widget with default styling.

17. **`CachedImage`** — Wraps `CachedNetworkImage` with loading spinner and error placeholder.

18. **`CustomDropdown`** — Styled `DropdownButton2` with consistent theming.

---

## 19. Localization Strategy

Use Flutter's built-in `gen_l10n` system:

```yaml
# l10n.yaml (project root)
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

Create ARB files for: en, hi, ar, fr, zh.

All user-visible strings must use `AppLocalizations.of(context)!.keyName`.

---

## 20. Testing Strategy

```
test/
├── unit/
│   ├── models/          # fromJson, toJson tests for every model
│   ├── repositories/    # Mock HTTP, test parsing and error handling
│   └── controllers/     # Mock repositories, test state transitions
├── widget/
│   ├── widgets/         # Test shared widgets render correctly
│   └── screens/         # Test screens render loading/error/loaded states
└── integration/
    └── flows/           # E2E login flow, navigation flow
```

---

## 21. Coding Standards

### Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/methods: `camelCase`
- Constants: `camelCase` (Dart convention, NOT SCREAMING_SNAKE)
- Private members: `_prefixed`
- Folders: `snake_case` (NO spaces, NO capitals)

### File Organization
```dart
// 1. Dart imports
// 2. Package imports
// 3. Project imports
// 4. Part directives (if any)
// 
// class definition
// - static constants
// - final fields
// - mutable fields
// - constructor
// - factory constructors
// - public methods
// - private methods
// - overrides (==, hashCode, toString)
```

### Rules
- Max 300 lines per file. Split large screens into sub-widgets.
- Max 50 lines per method. Extract helper methods.
- No `print()` — use structured logger.
- No `dynamic` except for JSON parsing boundaries.
- No `!` force-unwrap without comment explaining why it's safe.
- All public API documented with `///` comments.
- Use `const` constructors wherever possible.
- Prefer `final` over mutable variables.
- Use `late` sparingly and only with guaranteed initialization.

---

## 22. API Reference (Complete)

### Standard Response Envelope
```json
{
  "Status": true,
  "Message": "Success",
  "Result": <data>
}
```

### Endpoints

| # | Method | Path | Auth | Request | Response Result |
|---|---|---|---|---|---|
| 1 | POST | `/Login` | No | `application/x-www-form-urlencoded`: `grant_type=password&username=&password=&remember=true` | `{ access_token, token_type, expires_in }` |
| 2 | GET | `/Alumni/GetId` | Bearer | — | `string` (encrypted ID) |
| 3 | GET | `/Alumni/GetAlumniDirectoryPaging` | No | `?pageSize=&pageNumber=` | `List<Alumni>` |
| 4 | GET | `/Alumni/SearchAlumni` | No | `?name=&passoutYear=&degree=&branch=&membershipType=&pageSize=&pageNumber=` | `List<Alumni>` |
| 5 | GET | `/alumni` | No | `?EncryptedId=` | `Profile` object (nested) |
| 6 | POST | `/Alumni/Update` | Bearer | `?EncryptedId=`, JSON body | `UpdateProfile` result |
| 7 | PUT | `/Alumni/ChangeMembershipRequest/{encId}/{membershipId}` | Bearer | — | `{ Status, Message, Result: string }` |
| 8 | GET | `/Slider` | No | — | `List<string>` (image URLs) |
| 9 | GET | `/Events/GetEventPaging` | No | `?pageSize=&pageNumber=` | `List<Event>` |
| 10 | GET | `/Events/{id}` | No | — | `Event` object |
| 11 | GET | `/News/GetNewsPaging` | No | `?pageSize=&pageNumber=` | `List<News>` |
| 12 | GET | `/News/{id}` | No | — | `News` object |
| 13 | GET | `/MediaGalleries/GetMediaGalleryPaging` | No | `?pageSize=&pageNumber=` | `List<Media>` |
| 14 | GET | `/Achievements/GetAchievementPaging` | No | `?pageSize=&pageNumber=` | `List<Noteworthy>` |
| 15 | GET | `/DigitalDownload` | No | `?{Category}&pageSize=&pageNumber=` | `List<DigitalDownload>` |
| 16 | GET | `/DigitalDownload/{id}` | No | — | `DigitalDownload` object |
| 17 | GET | `/Country` | No | — | `List<Country>` |
| 18 | GET | `/State` | No | `?CountryId=` | `List<State>` |
| 19 | GET | `/City` | No | `?StateId=` | `List<City>` |
| 20 | GET | `/Branch` | No | — | `List<Branch>` |
| 21 | GET | `/Program` | No | — | `List<Program>` |
| 22 | GET | `/MembershipType` | No | — | `List<MembershipType>` |

### Download Categories (for endpoint #15)
| Category Param | Description |
|---|---|
| `Mobileskin` | Mobile Skins |
| `DesktopWallpaper` | Desktop Wallpapers |
| `Calendar` | Calendars |
| `CampaignDownload` | Campaign Downloads |
| `OtherMaterial` | Other Materials |

### Pagination
- Default `pageSize`: 10
- `pageNumber`: 1-indexed
- Determine "has more" by checking if returned count < pageSize

---

## 23. Implementation Order

Build the app in this exact order. Each step should be fully complete and tested before moving to the next.

### Phase 1: Foundation (No UI)
1. **Project setup** — `flutter create`, pubspec.yaml, folder structure
2. **Config** — `AppConfig`, environment setup
3. **Core: Network** — `ApiClient`, `NetworkInfo`, `ApiResponse`, exceptions
4. **Core: Storage** — `SecureStorageService`, storage keys
5. **Core: Utils** — Logger, validators, date utils
6. **Theme** — Colors, text styles, `AppTheme` (light + dark)
7. **Models** — ALL model classes (14+ files)

### Phase 2: Data Layer
8. **Repositories** — ALL repositories (10 files), each fully handling API calls and parsing

### Phase 3: Core UI
9. **Shared Widgets** — ALL shared widgets (18+ components)
10. **Routing** — GoRouter setup with all routes
11. **Provider Config** — Register all providers

### Phase 4: Feature Screens (in order)
12. **App Entry** — main.dart, app.dart, splash screen
13. **Home** — HomeScreen + HomeController + all 7 tabs
14. **Auth** — LoginScreen + AuthController
15. **News** — NewsListScreen + NewsDetailScreen + NewsController
16. **Events** — EventListScreen + EventDetailScreen + EventController
17. **Media** — MediaListScreen + MediaDetailScreen + MediaController
18. **Noteworthy** — NoteworthyListScreen + NoteworthyDetailScreen + NoteworthyController
19. **Alumni Directory** — AlumniDirectoryScreen + AlumniController
20. **Digital Downloads** — DownloadsScreen + DownloadDetailScreen + DigitalDownloadController
21. **Profile** — ProfileScreen + ProfileController (most complex — do last)
22. **Projects** — TreePlantation + ATHackathon (static)
23. **General** — About, MembershipTypes, NoInternet, Error screens

### Phase 5: Integration
24. **Firebase** — FCM setup, notification handling, deep linking
25. **Localization** — ARB files, integrate throughout
26. **Testing** — Unit + widget tests
27. **Polish** — Native splash, app icons, build optimization

---

## Quick Reference for AI Agents

### When creating a MODEL:
```
1. Create in lib/models/
2. Pure data class, no imports beyond dart:core and dart:convert
3. All fields final
4. const constructor with named required params
5. factory fromJson(Map<String, dynamic>)
6. Map<String, dynamic> toJson()
7. copyWith()
8. == and hashCode
```

### When creating a REPOSITORY:
```
1. Create in lib/repositories/
2. Constructor takes ApiClient
3. All methods return Future<Result<T>>
4. Parse API envelope (Status/Message/Result)
5. Map JSON to model objects
6. Catch exceptions → return Failure
```

### When creating a CONTROLLER:
```
1. Create in lib/controllers/
2. Extends ChangeNotifier
3. Constructor takes Repository
4. LoadState for each data set
5. Typed data storage
6. Pagination: currentPage, hasMore, loadMore()
7. Error handling: errorMessage, setError()
8. Call notifyListeners() after every state change
```

### When creating a SCREEN:
```
1. Create in lib/views/{feature}/
2. Prefer StatelessWidget
3. Wrap body with Consumer<Controller>
4. Switch on controller.state for loading/error/loaded
5. Use AppScaffold for consistent layout
6. Use shared widgets from lib/views/widgets/
7. Max 300 lines. Extract sub-widgets.
```

---

*This document version: 1.0 | Last updated: March 2026*
