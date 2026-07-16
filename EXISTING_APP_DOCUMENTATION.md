# LDCE Alumni App — Complete Documentation

> **App Name:** LDCE Connect (LDCE Alumni)  
> **Version:** 1.0.5+7  
> **Platform:** Flutter (Android + iOS)  
> **State Management:** Provider (ChangeNotifier)  
> **Architecture:** Loose MVC with Provider  
> **Base API:** `http://api.ldcealumni.net/api/`  
> **Firebase:** Core + Cloud Messaging (FCM)  
> **Package Name:** `ldce_alumni`

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Technology Stack](#2-technology-stack)
3. [Architecture Overview](#3-architecture-overview)
4. [Folder Structure](#4-folder-structure)
5. [App Entry Point](#5-app-entry-point)
6. [Feature Modules](#6-feature-modules)
7. [Models (Data Layer)](#7-models-data-layer)
8. [Controllers (Business Logic)](#8-controllers-business-logic)
9. [Views (UI Layer)](#9-views-ui-layer)
10. [Shared Widgets](#10-shared-widgets)
11. [Theme System](#11-theme-system)
12. [API Endpoints](#12-api-endpoints)
13. [Navigation & Routing](#13-navigation--routing)
14. [Authentication Flow](#14-authentication-flow)
15. [Firebase Integration](#15-firebase-integration)
16. [Localization](#16-localization)
17. [Assets & Fonts](#17-assets--fonts)
18. [Known Issues & Tech Debt](#18-known-issues--tech-debt)

---

## 1. Project Overview

LDCE Alumni App ("LDCE Connect") is a mobile application for the **L.D. College of Engineering Alumni Association** (established 1996). It serves as a platform for alumni to:

- Browse **News**, **Events**, **Media Galleries**, and **Noteworthy Alumni Mentions**
- Access an **Alumni Directory** with search/filter capabilities
- Download **Digital Materials** (wallpapers, skins, calendars, campaign materials)
- View **Projects** (Tree Plantation, AT Hackathon)
- Manage their **Profile** (personal, academic, contact, company info)
- Receive **Push Notifications** via Firebase Cloud Messaging
- **Login/Logout** with token-based authentication

---

## 2. Technology Stack

| Component | Technology | Version |
|---|---|---|
| Framework | Flutter | SDK >=3.0.0 <4.0.0 |
| Language | Dart | 3.x |
| State Management | Provider | ^6.0.5 |
| HTTP Client | http | ^1.1.0 |
| Image Caching | cached_network_image | ^3.2.3 |
| Firebase Core | firebase_core | ^4.5.0 |
| Push Notifications | firebase_messaging | ^16.1.2 |
| Secure Storage | flutter_secure_storage | latest |
| HTML Rendering | flutter_html | ^3.0.0-beta.2 |
| URL Launcher | url_launcher | ^6.1.14 |
| Carousel | carousel_slider | ^5.1.2 |
| Dropdown | dropdown_button2 | ^3.0.0 |
| Image Picker | image_picker | ^1.0.7 |
| Fonts | google_fonts | ^8.0.2 |
| Shimmer | shimmer | ^3.0.0 |
| Toast | fluttertoast | ^9.0.0 |
| Package Info | package_info_plus | ^9.0.0 |
| Icons | material_design_icons_flutter, flutter_feather_icons | latest |
| Sticky Headers | sticky_headers | ^0.3.0+2 |
| Splash Screen | flutter_native_splash | ^2.3.2 |
| Shared Preferences | shared_preferences | ^2.2.1 |
| Internationalization | intl | ^0.20.2 |

---

## 3. Architecture Overview

```text
┌────────────────────────────────────────────────────┐
│                    VIEWS (UI)                       │
│  Screens / Pages / Widgets                         │
│  Consumer<Controller> → reads state → builds UI    │
└──────────────────┬─────────────────────────────────┘
                   │ Provider.of / Consumer
┌──────────────────▼─────────────────────────────────┐
│              CONTROLLERS (Business Logic)           │
│  ChangeNotifier classes                            │
│  fetchData(), loadMore(), getSearch() etc.          │
│  Calls Model static methods → updates state        │
│  notifyListeners() after each change               │
└──────────────────┬─────────────────────────────────┘
                   │ Static method calls
┌──────────────────▼─────────────────────────────────┐
│               MODELS (Data Layer)                   │
│  Data classes with fromJson()                       │
│  Static API methods (getDummyList, getOne, etc.)    │
│  Direct HTTP calls to REST API                      │
│  JSON parsing and list construction                 │
└────────────────────────────────────────────────────┘
```

**Pattern:** Models contain both data structure AND API logic (static methods). Controllers call model methods, manage state, and expose data. Views consume controllers via Provider.

---

## 4. Folder Structure

```
lib/
├── main.dart                          # App entry, Firebase init, Provider setup, routes
├── generated_plugin_registrant.dart   # Auto-generated
├── controllers/
│   ├── alumni/
│   │   └── alumni_controller.dart     # Alumni directory logic
│   ├── auth/
│   │   └── auth_controller.dart       # Login, token management
│   ├── digital_downloads/
│   │   └── digital_downloads_controller.dart
│   ├── events/
│   │   └── events_controller.dart     # Upcoming/Past events
│   ├── home/
│   │   └── home_controller.dart       # Home screen aggregator
│   ├── media/
│   │   └── media_controller.dart
│   ├── news/
│   │   └── news_controller.dart
│   ├── noteworthy/
│   │   └── noteworthy_controller.dart
│   └── profile/
│       └── profile_controller.dart    # Profile CRUD, master data
├── core/
│   ├── globals.dart                   # BASE_API_URL, internet check, secure storage
│   ├── button.dart                    # Button utilities
│   ├── card.dart                      # Card utilities
│   ├── full_image_screen.dart         # Full-screen image viewer
│   ├── jumping_dots.dart              # Loading dots animation
│   ├── readmore.dart                  # Read more/less text widget
│   ├── text.dart                      # Text utilities
│   └── text_style.dart                # Text style utilities
├── extensions/
│   ├── extensions.dart                # Barrel file
│   ├── bool_extension.dart
│   ├── date_time_extension.dart
│   ├── double_extension.dart
│   ├── int.dart
│   ├── string.dart
│   ├── theme_extension.dart
│   └── widgets_extension.dart
├── localizations/
│   ├── app_localization_delegate.dart
│   ├── language.dart
│   └── translator.dart
├── models/
│   ├── alumni/
│   │   ├── alumni.dart                # Alumni data + API
│   │   └── alumni.json                # Sample data
│   ├── auth/
│   │   └── login.dart                 # Auth data + API
│   ├── digital_downloads/
│   │   ├── digital_downloads.dart
│   │   └── events.json
│   ├── events/
│   │   ├── events.dart                # Events data + API
│   │   └── events.json
│   ├── home/
│   │   ├── home.dart                  # Slider data + API
│   │   └── home.json
│   ├── masters/
│   │   ├── branch/                    # Branch, LBranch, ReqResult
│   │   ├── city/                      # City, LCity, ReqResult
│   │   ├── country/                   # Country, LCountry, ReqResult
│   │   ├── membership/               # MembershipTypes, ReqResult
│   │   ├── program/                   # Program, LProgram, ReqResult
│   │   ├── state/                     # States, LState, ReqResult
│   │   └── updatemembershiptype/      # UpdateMembershipType
│   ├── media/
│   │   ├── media.dart
│   │   └── media.json
│   ├── news/
│   │   ├── news.dart                  # News data + API
│   │   └── news.json
│   ├── noteworthy/
│   │   ├── noteworthy.dart
│   │   └── noteworthy.json
│   ├── profile/
│   │   ├── profile.dart               # Profile data + API
│   │   └── newprofile.dart            # Unused duplicate
│   ├── update profile/
│   │   └── updateprofile.dart         # Update profile data + API
│   └── country copy.dart             # Unused copy
├── theme/
│   ├── app_notifier.dart              # Theme ChangeNotifier
│   ├── app_theme.dart                 # Light/Dark ThemeData
│   ├── constant.dart
│   ├── custom_chat_theme.dart
│   ├── custom_theme.dart
│   ├── material_theme.dart
│   ├── navigation_theme.dart
│   ├── theme_type.dart                # ThemeType enum
│   └── themes.dart
├── utils/
│   ├── custom_badge_icons.dart
│   └── local_notification_service.dart.bk  # Backup/unused
└── views/
    ├── loading_effect.dart            # Shimmer loading effect
    ├── alumni_directory/
    │   └── alumni_directory_home.dart  # 945 lines, search + filters
    ├── auth/
    │   └── Login/
    │       ├── login_screen.dart
    │       ├── responsive.dart
    │       ├── constants.dart
    │       └── components/
    │           ├── background.dart
    │           ├── login_form.dart
    │           └── login_screen_top_image.dart
    ├── digital_downloads/
    │   ├── downloads_home_screen.dart  # 5-tab download categories
    │   ├── mobile_skins_screen.dart
    │   ├── desktop_wallpapers_screen.dart
    │   ├── calendars_screen.dart
    │   ├── campaign_downloads_screen.dart
    │   ├── other_materials_screen.dart
    │   ├── single_digital_download_screen.dart
    │   └── single_internet_digital_download_screen..dart
    ├── events/
    │   ├── event_home_screen.dart      # 2-tab: upcoming/past
    │   ├── event_upcoming_screen.dart
    │   ├── event_past_screen.dart
    │   ├── single_event_screen.dart
    │   └── single_internet_event_screen..dart
    ├── general/
    │   ├── about_us.dart
    │   ├── membership_types.dart
    │   ├── no_internet_screen.dart
    │   └── something_wrong_screen.dart
    ├── home/
    │   ├── home_screen.dart           # Main screen with tabs
    │   ├── home_home_tab.dart         # Welcome/About tab
    │   ├── home_news_tab.dart
    │   ├── home_events_tab.dart
    │   ├── home_media_tab.dart
    │   ├── home_noteworthy_tab.dart
    │   ├── home_downloads_tab.dart
    │   └── home_project_tab.dart
    ├── media/
    │   ├── media_home.dart
    │   └── single_media_screen.dart
    ├── news/
    │   ├── news_home.dart
    │   ├── single_news_screen.dart
    │   └── single_notification_news_screen.dart
    ├── noteworthy/
    │   ├── noteworthy_home.dart
    │   └── single_noteworthy_screen.dart
    ├── profile/
    │   └── profile_page.dart          # 2687 lines, full profile CRUD
    ├── projects/
    │   ├── at_hackathon.dart
    │   └── tree_plantation.dart
    └── widgets/
        ├── alumni_expansion.dart
        ├── app_bar_widget.dart         # Shared AppBar
        ├── app_drawer_widget.dart      # Shared Drawer (full navigation)
        ├── dropdown_widget.dart
        ├── expansion_tile_widget.dart
        ├── screen_arguments.dart       # Route argument passing
        ├── select_language_dialog.dart
        ├── simple_dialog.dart
        ├── single_alumni_card_widget..dart
        ├── single_card_widget.dart
        ├── single_download_widget.dart
        ├── single_event_home_widget.dart
        ├── single_event_widget.dart
        ├── single_grid_item.dart
        ├── single_home_alumni_card_widget.dart
        ├── single_news_card_widget..dart
        ├── single_news_home_card_widget.dart
        ├── single_news_widget.dart
        ├── single_project_home_card_widget.dart
        └── slide_animation.dart
```

---

## 5. App Entry Point

### `main.dart`

1. **Firebase Initialization** — `Firebase.initializeApp()`
2. **FCM Background Handler** — `_firebaseMessagingBackgroundHandler()`
3. **Notification Permissions** — Requests alert, badge, sound permissions
4. **Topic Subscriptions** — Subscribes to `all-android`/`all-ios`, debug topics
5. **Orientation Lock** — Portrait only
6. **Provider Setup** — 10 ChangeNotifierProviders:
   - `AppNotifier` (theme)
   - `HomeController`
   - `EventsController`
   - `MediaController`
   - `NoteworthyController`
   - `AlumniDirectoryController`
   - `NewsController`
   - `DigitalDownloadsController`
   - `AuthController`
   - `ProfileController`
7. **MaterialApp** — Named routes, theme from `AppTheme`, localization delegates
8. **Home Screen** — `HomeScreen` is the initial route

---

## 6. Feature Modules

### 6.1 Home
- **Purpose:** Main dashboard with carousel banner and 7 content tabs
- **Tabs:** Home (About), News, Events, Media, Noteworthy, Projects, Digital Downloads
- **Carousel:** Loads slider images from `/Slider` API
- **Each tab** shows a single latest item preview with "View All" navigation

### 6.2 News
- **List View:** Paginated news articles with infinite scroll
- **Detail View:** Full article with image gallery (PageView + thumbnails), HTML content
- **Notification Support:** Deep link to single news via FCM notification

### 6.3 Events
- **Two Tabs:** Upcoming Events / Past Events (split by comparing StartDate to now)
- **Detail View:** Event details with cover photo, date range, venue, contact person, attachments
- **Notification Support:** Deep link to single event via FCM

### 6.4 Media Gallery
- **List View:** Paginated media items with infinite scroll
- **Detail View:** Multi-image gallery with PageView and thumbnail strip, full-screen viewer

### 6.5 Noteworthy Mentions
- **List View:** Paginated alumni achievements
- **Detail View:** Achievement details with alumni name, branch, passout year

### 6.6 Alumni Directory
- **Search/Filter:** By name, program (B.E./M.E./MCA), branch (34 branches), passout year (1951–2026)
- **Pagination:** Previous/Next buttons
- **Display:** Expansion tiles showing alumni details (name, year, program, branch, membership, profession)

### 6.7 Digital Downloads
- **5 Categories:** Desktop Wallpapers, Mobile Skins, Calendars, Campaign Downloads, Other Materials
- **Tab-based navigation** with paginated lists within each tab

### 6.8 Projects
- **Tree Plantation:** Static page about Foundation Day plantation drives
- **AT Hackathon:** Static page about Assistive Technology hackathon with VOSAP

### 6.9 Profile
- **Sections:** Personal Info, Academic Info, Contact Info, Company Info
- **Features:** Profile picture upload (max 5MB), cascading dropdowns (country → state → city), year picker, form validation
- **Master Data:** Countries, States, Cities, Programs, Branches loaded from API
- **Edit Mode:** Toggle between view/edit with update API call

### 6.10 Authentication
- **Login:** Email + password → OAuth-style token (`access_token`)
- **Token Storage:** `FlutterSecureStorage` with encrypted shared preferences
- **Post-Login:** Stores encrypted alumni ID for API authorization
- **Logout:** Clears secure storage, navigates to home

---

## 7. Models (Data Layer)

### Content Models

| Model | Properties | API Methods |
|---|---|---|
| `Alumni` | name, passoutYear, program, branch, membership, profession | `getDummyList()`, `getSearchResult()` |
| `Auth` | access_token, token_type, expires_in | `doLogin()`, `getEncId()` |
| `Events` | coverPhoto, startDate, endDate, title, shortDescription, description, venue, contactPerson, attachmentList | `getDummyList()`, `getUpcomingDummyList()`, `getPastDummyList()`, `getOneEvent()` |
| `News` | imageUrl, date, title, shortDescription, description, attachmentList | `getDummyList()`, `getOneNews()` |
| `Media` | coverPhoto, date, title, shortDescription, description, imageList | `getDummyList()` |
| `Noteworthy` | coverPhoto, title, shortDescription, description, alumniName, alumniPassoutYear, alumniBranch | `getDummyList()` |
| `DigitalDownloads` | title, description, category, fileUrl, pdfFileUrl | `getDummyList()`, `getMobileSkinsList()`, `getDesktopWallpaperList()`, `getCalendarsList()`, `getCampaignDownloadsList()`, `getOtherMList()`, `getOneEvent()` |
| `Home` | imageUrl (slider) | `getDummyList()` |
| `Profile` | Status, Message, Result (34-field ReqResult: names, DOB, gender, address, education, company, membership) | `getProfileDetails()` |
| `UpdateProfile` | 36 fields (all profile + audit fields) | `updateProfileDetails()` |

### Master Models

| Model | Purpose | API Endpoint |
|---|---|---|
| `Country` / `LCountry` | Country dropdown | `GET /Country` |
| `States` / `LState` | State dropdown (by country) | `GET /State?CountryId=` |
| `City` / `LCity` | City dropdown (by state) | `GET /City?StateId=` |
| `Branch` / `LBranch` | Branch/stream dropdown | `GET /Branch` |
| `Program` / `LProgram` | Program/degree dropdown | `GET /Program` |
| `MembershipTypes` | Membership type list | `GET /MembershipType` |
| `UpdateMembershipType` | Change membership | `PUT /Alumni/ChangeMembershipRequest/{encId}/{membershipId}` |

### Common API Response Pattern

```json
{
  "Status": true,
  "Message": "Success",
  "Result": [ ... ] // or { ... } for single items
}
```

---

## 8. Controllers (Business Logic)

All controllers extend `ChangeNotifier` and follow this pattern:

```dart
class XController extends ChangeNotifier {
  bool showLoading = true;
  bool uiLoading = true;
  bool hasMoreData = true;
  bool exceptionCreated = false;
  List<X> items = [];
  
  XController() { fetchData(); }  // Auto-fetch on creation
  
  Future<void> fetchData() async {
    try {
      items = await X.getDummyList();
      showLoading = false;
      uiLoading = false;
    } catch (e) {
      exceptionCreated = true;
    }
    notifyListeners();
  }
  
  Future<void> loadMore(int pageNumber) async {
    // Pagination with hasMoreData flag
  }
}
```

### Controller Summary

| Controller | Key Responsibilities |
|---|---|
| `HomeController` | Aggregates preview data for home tabs (1 item each: news, event, media, noteworthy, download). Loads slider images. |
| `AuthController` | Login, token storage, encrypted ID retrieval |
| `NewsController` | News list, single news, pagination |
| `EventsController` | Upcoming/past events, single event, pagination for both |
| `MediaController` | Media gallery list, pagination, search (unused) |
| `NoteworthyController` | Noteworthy achievements list, pagination |
| `AlumniDirectoryController` | Alumni search with filters, pagination (both list and search results) |
| `DigitalDownloadsController` | 5-category downloads, single download, pagination per category |
| `ProfileController` | Full profile CRUD, master data loading (country/state/city/program/branch/membership), image upload, profile update |

### Cross-Cutting Patterns

- **Pagination:** `loadMore(pageNumber)` + `hasMoreData` flag + `globals.isAll*Loaded` global flags
- **Error Handling:** try/catch with `exceptionCreated = true` → navigates to "Something Wrong" screen
- **Internet Check:** `globals.checkInternet()` pings google.com
- **Loading States:** `showLoading` (main), `uiLoading` (skeleton shimmer)

---

## 9. Views (UI Layer)

### Screen Inventory

| Screen | File | Lines | Description |
|---|---|---|---|
| HomeScreen | `home/home_screen.dart` | ~400 | Main screen with carousel + 7 tabs |
| HomeTab | `home/home_home_tab.dart` | ~100 | Static "About" welcome page |
| HomeNewsTab | `home/home_news_tab.dart` | ~130 | Latest news preview |
| HomeEventsTab | `home/home_events_tab.dart` | ~130 | Latest event preview |
| HomeMediaTab | `home/home_media_tab.dart` | ~130 | Latest media preview |
| HomeNoteworthyTab | `home/home_noteworthy_tab.dart` | ~130 | Latest noteworthy preview |
| HomeDownloadsTab | `home/home_downloads_tab.dart` | ~130 | Latest download preview |
| HomeProjectTab | `home/home_project_tab.dart` | ~130 | Project cards list |
| LoginScreen | `auth/Login/login_screen.dart` | ~100 | Login layout |
| LoginForm | `auth/Login/components/login_form.dart` | ~200 | Email/password form |
| EventHomeScreen | `events/event_home_screen.dart` | ~200 | 2-tab events (upcoming/past) |
| EventUpcomingScreen | `events/event_upcoming_screen.dart` | ~200 | Upcoming events list |
| EventPastScreen | `events/event_past_screen.dart` | ~200 | Past events list |
| SingleEventScreen | `events/single_event_screen.dart` | ~300 | Event detail with gallery |
| NewsHomeScreen | `news/news_home.dart` | ~300 | News list with pagination |
| SingleNewsScreen | `news/single_news_screen.dart` | ~350 | News detail with gallery |
| MediaHomeScreen | `media/media_home.dart` | ~200 | Media list with pagination |
| SingleMediaScreen | `media/single_media_screen.dart` | ~300 | Media detail with gallery |
| NoteworthyHomeScreen | `noteworthy/noteworthy_home.dart` | ~200 | Noteworthy list with pagination |
| SingleNoteworthyScreen | `noteworthy/single_noteworthy_screen.dart` | ~250 | Noteworthy detail |
| AlumniDirectoryHome | `alumni_directory/alumni_directory_home.dart` | ~945 | Search + filter + paginated directory |
| DownloadsHomeScreen | `digital_downloads/downloads_home_screen.dart` | ~200 | 5-tab categorized downloads |
| ProfileScreen | `profile/profile_page.dart` | ~2687 | Full profile CRUD with forms |
| AboutUsScreen | `general/about_us.dart` | ~200 | Static about page |
| MemberShipTypes | `general/membership_types.dart` | ~150 | Static membership info |
| NoInternetScreen | `general/no_internet_screen.dart` | ~100 | No internet error with retry |
| SomethingWrongScreen | `general/something_wrong_screen.dart` | ~100 | Generic error with retry |
| ATHackathon | `projects/at_hackathon.dart` | ~200 | Static project page |
| TreePlantationScreen | `projects/tree_plantation.dart` | ~200 | Static project page |

---

## 10. Shared Widgets

| Widget | Purpose |
|---|---|
| `AppBarWidget` | Shared AppBar with logo, title, profile avatar, drawer trigger |
| `AppDrawerWidget` | Full navigation drawer with all routes, login/logout, version |
| `SingleCardWidget` | Reusable card (image + title + description) for media/general |
| `SingleNewsCardWidget` | News-specific card widget |
| `SingleNewsHomeCardWidget` | News card for home preview |
| `SingleEventWidget` | Event card for event list |
| `SingleEventHomeWidget` | Event card for home preview |
| `SingleAlumniCardWidget` | Alumni/noteworthy card |
| `SingleHomeAlumniCardWidget` | Alumni card for home preview |
| `SingleDownloadWidget` | Download item card |
| `SingleProjectHomeCardWidget` | Project card for home |
| `AlumniDirectoryExpansionWidget` | Expansion tile for alumni directory |
| `DropdownWidget` | Custom dropdown wrapper |
| `ExpansionTileWidget` | Custom expansion tile |
| `ScreenArguments` | Route argument data class (id: String) |
| `SelectLanguageDialog` | Language selection dialog |
| `SimpleDialog` | Generic dialog |
| `SlideAnimation` | Slide-in animation widget |

---

## 11. Theme System

### ThemeType Enum
- `ThemeType.light`
- `ThemeType.dark`

### AppTheme
- **Light Theme:** Primary `#3C4EC5`, scaffold white, Montserrat font family
- **Dark Theme:** Primary `#069DEF`, scaffold `#161616`
- **Custom Theme:** Extended colors for cards, borders, disable states
- **Google Fonts:** Montserrat as base

### AppNotifier
- `ChangeNotifier` for theme changes
- Methods: `updateTheme(themeType)`, `changeDirectionality()`, `changeLanguage(lang)`

---

## 12. API Endpoints

### Base URL: `http://api.ldcealumni.net/api/`

| HTTP | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/Login` | None | Login (form-encoded: grant_type, username, password) |
| GET | `/Alumni/GetId` | Bearer | Get encrypted alumni ID |
| GET | `/Alumni/GetAlumniDirectoryPaging?pageSize=&pageNumber=` | None | Paginated alumni directory |
| GET | `/Alumni/SearchAlumni?name=&passoutYear=&degree=&branch=&membershipType=&pageSize=&pageNumber=` | None | Search alumni |
| GET | `/alumni?EncryptedId=` | None | Get profile (encId from secure storage) |
| POST | `/Alumni/Update?EncryptedId=` | Bearer | Update profile (JSON body) |
| PUT | `/Alumni/ChangeMembershipRequest/{encId}/{membershipId}` | Bearer | Change membership |
| GET | `/Slider` | None | Homepage slider images |
| GET | `/Events/GetEventPaging?pageSize=&pageNumber=` | None | Paginated events |
| GET | `/Events/{id}` | None | Single event |
| GET | `/News/GetNewsPaging?pageSize=&pageNumber=` | None | Paginated news |
| GET | `/News/{id}` | None | Single news |
| GET | `/MediaGalleries/GetMediaGalleryPaging?pageSize=&pageNumber=` | None | Paginated media |
| GET | `/Achievements/GetAchievementPaging?pageSize=&pageNumber=` | None | Paginated noteworthy |
| GET | `/DigitalDownload?{Category}&pageSize=&pageNumber=` | None | Downloads by category |
| GET | `/DigitalDownload/{id}` | None | Single download |
| GET | `/Country` | None | Country list |
| GET | `/State?CountryId=` | None | States by country |
| GET | `/City?StateId=` | None | Cities by state |
| GET | `/Branch` | None | Branch list |
| GET | `/Program` | None | Program list |
| GET | `/MembershipType` | None | Membership types |

---

## 13. Navigation & Routing

### Named Routes

| Route | Screen |
|---|---|
| `'home'` | `HomeScreen` |
| `'login'` | `LoginScreen` |
| `'profile'` | `ProfileScreen` |
| `'events_home'` | `EventHomeScreen` |
| `'news_home'` | `NewsHomeScreen` |
| `'media_home'` | `MediaHomeScreen` |
| `'noteworthy_home'` | `NoteworthyHomeScreen` |
| `'alumni_directory_home'` | `AlumniDirectoryHome` |
| `'downloads_home'` | `DownloadsHomeScreen` |
| `'tree_plantation'` | `TreePlantationScreen` |
| `'at_hackathon'` | `ATHackathon` |
| `'about_us'` | `AboutUsScreen` |
| `'membership_types'` | `MemberShipTypes` |
| `'something_wrong'` | `SomethingWrongScreen` |
| `'no_internet_screen'` | `SingleInternetNewsScreen` |
| `'single_internet_news_screen'` | `SingleInternetNewsScreen` |
| `'single_internet_events_screen'` | `SingleInternetEventScreen` |

### Navigation Patterns
- **Named Routes:** `Navigator.pushNamed(context, 'route')`
- **Material Routes:** `Navigator.push(context, MaterialPageRoute(...))`
- **Replace All:** `Navigator.pushAndRemoveUntil(...)` for error/internet screens
- **Deep Links:** FCM notifications navigate to specific news/event via `ScreenArguments(id)`

---

## 14. Authentication Flow

```text
1. User opens LoginScreen
2. Enters email + password
3. AuthController.login() →
   a. Auth.doLogin(email, password) → POST /Login
   b. Receives { access_token, token_type, expires_in }
   c. Stores access_token in FlutterSecureStorage
   d. AuthController.storeEncId() →
      i. Auth.getEncId() → GET /Alumni/GetId (Bearer token)
      ii. Stores encId in FlutterSecureStorage
4. Navigate to HomeScreen
5. Profile/authenticated screens read token from secure storage
6. Logout → Clear secure storage → Navigate to home
```

---

## 15. Firebase Integration

### Firebase Cloud Messaging (FCM)
- **Background Handler:** `_firebaseMessagingBackgroundHandler()` — initialized at top level
- **Foreground:** Alert, badge, sound enabled
- **Topics Subscribed:**
  - `all-android` (Android only)
  - `all-ios` (iOS only)  
  - `all-dhrumil` (always)
  - `all-dhrumil-dev-11`, `all`, `all-dhrumil-b-sandbox` (debug only)
- **Notification Handling:**
  - `getInitialMessage()` — app launched from terminated state
  - `onMessageOpenedApp` — app in background, notification tapped
  - Deep-link navigation to news (`'single_internet_news_screen'`) or events (`'single_internet_events_screen'`) based on notification data type

### Notification Data Structure
```json
{
  "type": "news" | "event",
  "id": "<item_id>"
}
```

---

## 16. Localization

- **Supported Locales:** English (en), Hindi (hi), Arabic (ar), French (fr), Chinese (zh)
- **Translation Files:** `assets/lang/{locale}.json`
- **Delegate:** `AppLocalizationsDelegate`
- **Translator:** Custom translator class reading from JSON files
- **Language Model:** `Language` class with locale list

---

## 17. Assets & Fonts

### Assets
- `assets/images/` — App images, logos
- `assets/images/banners/` — Banner images
- `assets/fonts/` — Custom fonts

### Fonts
- **Montserrat** — Primary app font (custom asset: `assets/fonts/montserrat.ttf`)
- **CustomBadge** — Badge icon font (`assets/fonts/CustomBadge.ttf`)
- **Google Fonts** — Montserrat via `google_fonts` package (for TextTheme)

---

## 18. Known Issues & Tech Debt

### Architecture Issues
1. **Models contain API logic** — Data classes should be pure; API calls should be in a repository/service layer
2. **Global mutable flags** — `globals.isAll*Loaded` are global booleans, not encapsulated in state
3. **No dependency injection** — All controllers instantiated at top level with no DI
4. **No repository pattern** — Controllers call model static methods directly
5. **Duplicate code** — `checkInternet()` defined in both `globals.dart` and `main.dart`
6. **Duplicate models** — `newprofile.dart` duplicates `profile.dart`; `country copy.dart` unused

### Code Quality Issues
7. **Massive files** — `profile_page.dart` (2687 lines), `alumni_directory_home.dart` (945 lines)
8. **Naming inconsistencies** — Files with double dots (`single_internet_event_screen..dart`), spaces in folder names (`update profile/`)
9. **Methods named `getDummyList`** — Confusing naming for production API calls
10. **String comparison bug** — `country copy.dart` compares `response.statusCode` (int) to `"200"` (string)
11. **No null safety enforcement** — Many nullable types used without proper handling
12. **Hardcoded strings** — UI text not fully localized, many hardcoded strings
13. **No error logging** — Only `print()` statements, no structured logging
14. **No tests** — Only default `widget_test.dart` placeholder
15. **Commented-out code** — Extensive commented blocks throughout (local notifications, etc.)
16. **No environment configuration** — Sandbox URL commented out, production URL hardcoded
17. **HTTP (not HTTPS)** for base API URL
18. **No token refresh mechanism** — Token stored but no refresh/expiry handling
19. **Missing loading/error states** — Some screens don't properly handle all states
20. **No offline support** — No local caching or offline-first strategy
