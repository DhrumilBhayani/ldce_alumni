# PROMPT: Build LDCE Alumni Flutter App v2 — Production-Ready Boilerplate

> **Give this entire file to your AI coding agent. It contains everything needed to scaffold the complete app.**

---

## TASK

You are building a **brand-new Flutter app** from scratch for the LDCE Alumni Association ("LDCE Connect"). This is a rebuild of a 4-year-old app. You must create a **production-ready, scalable boilerplate** with the **MVC + Provider** pattern, a proper **repository layer**, and every screen/controller/model stubbed out and wired together.

**Create the project inside a new folder called `ldce_alumni_v2`.**

Run `flutter create ldce_alumni_v2 --org com.ldcealumni` first, then replace/create all files as specified below.

---

## ARCHITECTURE

```
View (Screens + Widgets)
    ↓ consumes via Provider Consumer<Controller>
Controller (ChangeNotifier)
    ↓ calls methods on
Repository (API + JSON parsing)
    ↓ uses
ApiClient (HTTP wrapper) + Models (pure data classes)
```

**Rules:**
- Models = pure data. No API calls, no HTTP imports. Only `dart:core`/`dart:convert`.
- Repositories = all HTTP I/O. Accept `ApiClient` in constructor. Return `Result<T>` (sealed class: `Success<T>` | `Failure<T>`).
- Controllers = `ChangeNotifier`. Accept Repository in constructor. Manage `LoadState`, data, pagination, errors. Call `notifyListeners()`.
- Views = UI only. Consume Controller via `Consumer`. Render based on `LoadState`. Zero business logic.
- No global mutable state. No `print()`. No commented-out code. No dead code.

---

## FOLDER STRUCTURE — Create exactly this

```
lib/
├── main.dart
├── app.dart
├── config/
│   ├── app_config.dart
│   ├── routes.dart
│   └── provider_config.dart
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── asset_constants.dart
│   ├── enums/
│   │   ├── load_state.dart
│   │   └── download_category.dart
│   ├── errors/
│   │   ├── app_exception.dart
│   │   └── result.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   └── api_response.dart
│   ├── storage/
│   │   ├── secure_storage_service.dart
│   │   └── storage_keys.dart
│   └── utils/
│       ├── date_utils.dart
│       ├── validators.dart
│       └── logger.dart
├── models/
│   ├── alumni.dart
│   ├── auth_token.dart
│   ├── digital_download.dart
│   ├── event.dart
│   ├── home_slider.dart
│   ├── media_item.dart
│   ├── membership_type.dart
│   ├── news.dart
│   ├── noteworthy.dart
│   ├── profile.dart
│   ├── update_profile_request.dart
│   └── masters/
│       ├── branch.dart
│       ├── city.dart
│       ├── country.dart
│       ├── program.dart
│       └── l_state.dart
├── repositories/
│   ├── auth_repository.dart
│   ├── alumni_repository.dart
│   ├── event_repository.dart
│   ├── news_repository.dart
│   ├── media_repository.dart
│   ├── noteworthy_repository.dart
│   ├── digital_download_repository.dart
│   ├── home_repository.dart
│   ├── profile_repository.dart
│   └── master_repository.dart
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
│   └── theme_controller.dart
├── views/
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── auth/
│   │   └── login_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── tabs/
│   │       ├── home_tab.dart
│   │       ├── news_tab.dart
│   │       ├── events_tab.dart
│   │       ├── media_tab.dart
│   │       ├── noteworthy_tab.dart
│   │       ├── downloads_tab.dart
│   │       └── projects_tab.dart
│   ├── news/
│   │   ├── news_list_screen.dart
│   │   └── news_detail_screen.dart
│   ├── events/
│   │   ├── event_list_screen.dart
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
│   │   ├── downloads_screen.dart
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
├── views/widgets/
│   ├── app_scaffold.dart
│   ├── custom_app_bar.dart
│   ├── app_drawer.dart
│   ├── content_card.dart
│   ├── news_card.dart
│   ├── event_card.dart
│   ├── alumni_card.dart
│   ├── download_card.dart
│   ├── image_gallery.dart
│   ├── full_image_viewer.dart
│   ├── loading_shimmer.dart
│   ├── app_error_widget.dart
│   ├── empty_state_widget.dart
│   ├── pagination_loader.dart
│   ├── section_header.dart
│   ├── html_content.dart
│   ├── cached_image.dart
│   └── custom_dropdown.dart
├── extensions/
│   ├── build_context_extensions.dart
│   ├── string_extensions.dart
│   ├── date_extensions.dart
│   └── widget_extensions.dart
├── theme/
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   ├── app_theme.dart
│   └── app_spacing.dart
└── l10n/
    └── app_en.arb
```

---

## PUBSPEC.YAML

```yaml
name: ldce_alumni_v2
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
  provider: ^6.1.2
  go_router: ^14.0.0
  http: ^1.2.1
  connectivity_plus: ^6.0.0
  firebase_core: ^3.0.0
  firebase_messaging: ^15.0.0
  flutter_secure_storage: ^9.2.0
  shared_preferences: ^2.2.3
  cached_network_image: ^3.3.1
  carousel_slider: ^5.0.0
  shimmer: ^3.0.0
  flutter_html: ^3.0.0-beta.2
  google_fonts: ^6.2.1
  dropdown_button2: ^2.3.9
  fluttertoast: ^8.2.4
  material_design_icons_flutter: ^7.0.7296
  image_picker: ^1.0.7
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
  assets:
    - assets/images/
    - assets/images/banners/
  fonts:
    - family: Montserrat
      fonts:
        - asset: assets/fonts/montserrat.ttf
    - family: CustomBadge
      fonts:
        - asset: assets/fonts/CustomBadge.ttf
```

---

## FILE-BY-FILE SPECIFICATIONS

### CONFIG LAYER

#### `config/app_config.dart`
```
enum Environment { dev, staging, prod }

class AppConfig with:
  - environment (Environment)
  - baseApiUrl (String)
  - appName (String)  
  - apiTimeoutSeconds (int) = 40
  - defaultPageSize (int) = 10

Three const instances:
  - dev:  baseApiUrl = 'https://ldcealumniapi.devitsandbox.com/api'
  - staging: same as dev
  - prod: baseApiUrl = 'http://api.ldcealumni.net/api'
```

#### `config/routes.dart`
```
Use GoRouter. Define route path constants as static strings in AppRoutes class.

Routes:
  /                          → SplashScreen
  /home                      → HomeScreen
  /login                     → LoginScreen
  /profile                   → ProfileScreen (redirect to /login if not authenticated)
  /news                      → NewsListScreen
  /news/:id                  → NewsDetailScreen
  /events                    → EventListScreen
  /events/:id                → EventDetailScreen
  /media                     → MediaListScreen
  /media/:id                 → MediaDetailScreen
  /noteworthy                → NoteworthyListScreen
  /noteworthy/:id            → NoteworthyDetailScreen
  /alumni-directory          → AlumniDirectoryScreen
  /downloads                 → DownloadsScreen
  /downloads/:id             → DownloadDetailScreen
  /projects/tree-plantation  → TreePlantationScreen
  /projects/at-hackathon     → AtHackathonScreen
  /about                     → AboutScreen
  /membership-types          → MembershipTypesScreen
  /no-internet               → NoInternetScreen
  /error                     → ErrorScreen

Initial location: '/'
Add redirect logic: splash checks auth token existence and routes to /home.
Profile route checks for auth token, redirects to /login if missing.
```

#### `config/provider_config.dart`
```
class ProviderConfig with a static method:
  static Widget wrap(Widget child)
  
Returns MultiProvider wrapping child with ALL controllers:
  - ThemeController
  - AuthController(authRepository)
  - HomeController(homeRepository, newsRepository, eventRepository, mediaRepository, noteworthyRepository, digitalDownloadRepository)
  - NewsController(newsRepository)
  - EventController(eventRepository)
  - MediaController(mediaRepository)
  - NoteworthyController(noteworthyRepository)
  - AlumniController(alumniRepository)
  - DigitalDownloadController(digitalDownloadRepository)
  - ProfileController(profileRepository, masterRepository)

All repositories should be instantiated here with ApiClient passed in.
ApiClient should be constructed with the AppConfig.
```

---

### CORE LAYER

#### `core/constants/api_constants.dart`
```
class ApiConstants — static const Strings for all API paths (NOT full URLs, just paths):
  login = '/Login'
  getAlumniId = '/Alumni/GetId'
  alumniPaging = '/Alumni/GetAlumniDirectoryPaging'
  alumniSearch = '/Alumni/SearchAlumni'
  alumniProfile = '/alumni'
  alumniUpdate = '/Alumni/Update'
  changeMembership = '/Alumni/ChangeMembershipRequest'
  slider = '/Slider'
  eventsPaging = '/Events/GetEventPaging'
  eventsById = '/Events'
  newsPaging = '/News/GetNewsPaging'
  newsById = '/News'
  mediaPaging = '/MediaGalleries/GetMediaGalleryPaging'
  achievementsPaging = '/Achievements/GetAchievementPaging'
  digitalDownload = '/DigitalDownload'
  country = '/Country'
  state = '/State'
  city = '/City'
  branch = '/Branch'
  program = '/Program'
  membershipType = '/MembershipType'
```

#### `core/constants/app_constants.dart`
```
class AppConstants:
  defaultPageSize = 10
  apiTimeout = 40 (seconds)
  maxImageUploadSizeMB = 5
  minPassoutYear = 1951
  maxPassoutYearOffset = 2 (current year + 2)
```

#### `core/constants/asset_constants.dart`
```
class AssetConstants:
  logo = 'assets/images/75.png'
  logoDark = 'assets/images/75_black.png'
  placeholder = 'assets/images/placeholder.png'
```

#### `core/enums/load_state.dart`
```
enum LoadState { initial, loading, loaded, error, loadingMore }
```

#### `core/enums/download_category.dart`
```
enum DownloadCategory {
  mobileSkin('Mobileskin', 'Mobile Skins'),
  desktopWallpaper('DesktopWallpaper', 'Desktop Wallpapers'),
  calendar('Calendar', 'Calendars'),
  campaignDownload('CampaignDownload', 'Campaign Downloads'),
  otherMaterial('OtherMaterial', 'Other Materials');

  final String apiParam;
  final String displayName;
  const DownloadCategory(this.apiParam, this.displayName);
}
```

#### `core/errors/app_exception.dart`
```
sealed class AppException implements Exception:
  - message (String)
  - statusCode (int?)

Subclasses:
  - NetworkException (no internet)
  - TimeoutException (request timed out)
  - ServerException (5xx errors)
  - UnauthorizedException (401)
  - NotFoundException (404)
  - BadRequestException (400)
  - UnknownException (catch-all)
```

#### `core/errors/result.dart`
```
sealed class Result<T>:
  - Success<T>(T data)
  - Failure<T>(AppException exception)

Add convenience methods:
  - bool get isSuccess
  - bool get isFailure
  - T? get dataOrNull
  - AppException? get exceptionOrNull
```

#### `core/network/api_client.dart`
```
class ApiClient:
  Constructor takes AppConfig and SecureStorageService.

  Methods:
    Future<http.Response> get(String path, {Map<String, String>? queryParams, bool requiresAuth = false})
    Future<http.Response> post(String path, {dynamic body, bool requiresAuth = false, String? contentType})
    Future<http.Response> put(String path, {dynamic body, bool requiresAuth = false})

  Implementation:
    - Constructs full URL: config.baseApiUrl + path
    - Adds query params if provided
    - Sets headers: Content-Type: application/json (default), Accept: application/json
    - If requiresAuth: reads 'access_token' from SecureStorageService, adds Authorization: Bearer {token}
    - Sets timeout: config.apiTimeoutSeconds
    - Catches SocketException → throw NetworkException
    - Catches TimeoutException → throw TimeoutException  
    - Checks status codes: 401 → UnauthorizedException, 404 → NotFoundException, 500+ → ServerException
    - Logs request/response in debug mode via AppLogger
```

#### `core/network/api_response.dart`
```
class ApiResponse<T>:
  - status (bool)
  - message (String)
  - result (T?)

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) parseResult):
    return ApiResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: json['Result'] != null ? parseResult(json['Result']) : null,
    );
```

#### `core/storage/storage_keys.dart`
```
class StorageKeys:
  static const accessToken = 'access_token'
  static const encryptedId = 'encId'
  static const themeMode = 'theme_mode'
```

#### `core/storage/secure_storage_service.dart`
```
class SecureStorageService:
  Wraps FlutterSecureStorage with AndroidOptions(encryptedSharedPreferences: true).

  Methods:
    Future<void> write(String key, String value)
    Future<String?> read(String key)
    Future<void> delete(String key)
    Future<void> deleteAll()
    Future<bool> hasKey(String key)
```

#### `core/utils/logger.dart`
```
class AppLogger:
  static void debug(String message, {String? tag})  — only logs in kDebugMode
  static void error(String message, {Object? error, StackTrace? stackTrace, String? tag})
  static void info(String message, {String? tag})
  Use developer log() from dart:developer, NOT print().
```

#### `core/utils/validators.dart`
```
class Validators:
  static String? email(String? value) — returns error string or null
  static String? required(String? value)
  static String? password(String? value) — min 6 chars
  static String? phone(String? value)
  static String? maxFileSize(int bytes, int maxMB) — checks file size
```

#### `core/utils/date_utils.dart`  (name it `app_date_utils.dart` to avoid conflict with Flutter's)
```
class AppDateUtils:
  static String formatDisplay(DateTime date) → 'dd MMM yyyy'
  static String formatApi(DateTime date) → ISO 8601
  static DateTime? tryParse(String? dateStr) — safely parse API date strings
  static bool isFuture(DateTime date) → date.isAfter(DateTime.now())
  static bool isPast(DateTime date) → date.isBefore(DateTime.now())
```

---

### MODEL LAYER

Every model: `const` constructor, named required params, `fromJson` factory, `toJson`, `copyWith`, `==`, `hashCode`, `toString`.

#### `models/alumni.dart`
```dart
class Alumni {
  final String name;         // JSON: FullName
  final String passoutYear;  // JSON: PassoutYear
  final String program;      // JSON: Program
  final String branch;       // JSON: Branch
  final String membership;   // JSON: Membership
  final String profession;   // JSON: CompanyName
}
```

#### `models/auth_token.dart`
```dart
class AuthToken {
  final String accessToken;  // JSON: access_token
  final String tokenType;    // JSON: token_type
  final int expiresIn;       // JSON: expires_in
}
```

#### `models/event.dart`
```dart
class Event {
  final String? id;                // JSON: Id
  final String coverPhoto;         // JSON: CoverPhotoPath
  final DateTime startDate;        // JSON: StartDate (parse from string)
  final DateTime endDate;          // JSON: EndDate (parse from string)
  final String title;              // JSON: Title
  final String shortDescription;   // JSON: Description
  final String description;        // JSON: HtmlContent
  final String venue;              // JSON: Venue
  final String contactPerson;      // JSON: ContactPerson
  final List<String> attachments;  // JSON: Attachement[].Path
}
```

#### `models/news.dart`
```dart
class News {
  final String? id;                // JSON: Id
  final String imageUrl;           // JSON: CoverPhotoPath
  final DateTime date;             // JSON: CreatedOn (parse from string)
  final String title;              // JSON: Title
  final String shortDescription;   // JSON: Description
  final String description;        // JSON: HtmlContent
  final List<String> attachments;  // JSON: Attachement[].Path
}
```

#### `models/media_item.dart`
```dart
class MediaItem {
  final String? id;                // JSON: Id
  final String coverPhoto;         // JSON: CoverPhotoPath
  final DateTime date;             // JSON: CreatedOn
  final String title;              // JSON: Title
  final String shortDescription;   // JSON: Description
  final String description;        // JSON: HtmlContent
  final List<String> images;       // JSON: Attachement list → extract paths
}
```

#### `models/noteworthy.dart`
```dart
class Noteworthy {
  final String? id;                // JSON: Id
  final String coverPhoto;         // JSON: CoverPhotoPath
  final String title;              // JSON: Title
  final String shortDescription;   // JSON: Description
  final String description;        // JSON: HtmlContent
  final String alumniName;         // JSON: AlumniName
  final String alumniBranch;       // JSON: AlumniBranch
  final String alumniPassoutYear;  // JSON: AlumniPassoutYear
}
```

#### `models/digital_download.dart`
```dart
class DigitalDownload {
  final String? id;           // JSON: Id
  final String title;         // JSON: Title
  final String description;   // JSON: Description
  final String category;      // JSON: CategoryType
  final String fileUrl;       // JSON: FileName
  final String pdfFileUrl;    // JSON: PDFFileName
}
```

#### `models/home_slider.dart`
```dart
class HomeSlider {
  final String imageUrl;
  // Special: fromJson takes a String directly (not Map), because API Result is List<String>
  factory HomeSlider.fromJson(String url) => HomeSlider(imageUrl: url);
}
```

#### `models/profile.dart`
```dart
class Profile {
  final String encryptedId;           // JSON: EncryptedId
  final String firstName;             // JSON: FirstName
  final String middleName;            // JSON: MiddleName
  final String lastName;              // JSON: LastName
  final String fullName;              // JSON: FullName
  final bool gender;                  // JSON: Gender (true=male)
  final String dob;                   // JSON: DOB
  final int countryId;                // JSON: CountryId
  final int stateId;                  // JSON: StateId
  final int cityId;                   // JSON: CityId
  final String countryName;           // JSON: CountryName
  final String stateName;             // JSON: StateName
  final String cityName;              // JSON: CityName
  final String profilePicPath;        // JSON: ProfilePicPath
  final String primaryAddress;        // JSON: PrimaryAddress
  final String secondaryAddress;      // JSON: SecondaryAddress
  final String emailAddress;          // JSON: EmailAddress
  final String pinCode;               // JSON: PinCode
  final String mobileNo;              // JSON: MobileNo
  final String telephoneNo;           // JSON: TelephoneNo
  final String companyName;           // JSON: CompanyName
  final String companyAddress;        // JSON: CompanyAddress
  final String designation;           // JSON: Designation
  final String passoutYear;           // JSON: PassoutYear
  final int streamId;                 // JSON: StreamId
  final int degreeId;                 // JSON: DegreeId
  final String streamName;            // JSON: StreamName
  final String degreeName;            // JSON: DegreeName
  final int membershipTypeId;         // JSON: MembershipTypeId
  final String membership;            // JSON: Membership
  final bool isMembershipVerified;    // JSON: IsMembershipVerified
  final bool isEligibleForChangeMembership; // JSON: IsEligibleForChangeMembership
  final bool isChangeMembershipRequestSent; // JSON: IsChangeMembershipRequestSent
  final String requestStatus;         // JSON: RequestStatus
}
```

#### `models/update_profile_request.dart`
```dart
// Only needs toJson(). Used as POST body for profile update.
// Fields mirror Profile but as a mutable request object.
class UpdateProfileRequest {
  String firstName, middleName, lastName, dob, primaryAddress, secondaryAddress, 
    emailAddress, pinCode, mobileNo, telephoneNo, companyName, companyAddress, 
    designation, passoutYear;
  bool gender;
  int countryId, stateId, cityId, streamId, degreeId;

  Map<String, dynamic> toJson() => { ... all fields mapped to API keys ... };
}
```

#### `models/membership_type.dart`
```dart
class MembershipType {
  final int id;           // JSON: Id
  final String name;      // JSON: Name
  final String extraName; // JSON: ExtraName
  final int fees;         // JSON: Fees
  final int sequence;     // JSON: Sequence
}
```

#### `models/masters/branch.dart`, `city.dart`, `country.dart`, `program.dart`, `l_state.dart`
```dart
// All identical shape:
class Branch { // (or City, Country, Program, LState)
  final int id;      // JSON: Id
  final String name;  // JSON: Name
}
```

---

### REPOSITORY LAYER

Every repository: constructor takes `ApiClient`. Methods return `Future<Result<T>>`. Parse the `{ Status, Message, Result }` envelope. Map `Result` JSON to model objects. Catch `AppException` → return `Failure`.

#### `repositories/auth_repository.dart`
```
Methods:
  Future<Result<AuthToken>> login(String email, String password)
    POST /Login
    Content-Type: application/x-www-form-urlencoded
    Body: grant_type=password&username={email}&password={password}&remember=true
    Parse response body directly as AuthToken (not wrapped in Status/Message/Result envelope)

  Future<Result<String>> getEncId()
    GET /Alumni/GetId (requiresAuth: true)
    Returns the Result field as a String (the encrypted ID)
```

#### `repositories/home_repository.dart`
```
Methods:
  Future<Result<List<HomeSlider>>> getSliders()
    GET /Slider
    Result is List<String> (image URLs). Map each to HomeSlider.fromJson(url).
```

#### `repositories/news_repository.dart`
```
Methods:
  Future<Result<List<News>>> getNews({int pageSize = 10, int pageNumber = 1})
    GET /News/GetNewsPaging?pageSize={pageSize}&pageNumber={pageNumber}

  Future<Result<News>> getNewsById(String id)
    GET /News/{id}
```

#### `repositories/event_repository.dart`
```
Methods:
  Future<Result<List<Event>>> getEvents({int pageSize = 10, int pageNumber = 1})
    GET /Events/GetEventPaging?pageSize={pageSize}&pageNumber={pageNumber}
    NOTE: API returns ALL events. Split into upcoming/past by checking startDate > now.
    Return the full list; let controller do the split.

  Future<Result<Event>> getEventById(String id)
    GET /Events/{id}
```

#### `repositories/media_repository.dart`
```
Methods:
  Future<Result<List<MediaItem>>> getMedia({int pageSize = 10, int pageNumber = 1})
    GET /MediaGalleries/GetMediaGalleryPaging?pageSize={pageSize}&pageNumber={pageNumber}
```

#### `repositories/noteworthy_repository.dart`
```
Methods:
  Future<Result<List<Noteworthy>>> getNoteworthy({int pageSize = 10, int pageNumber = 1})
    GET /Achievements/GetAchievementPaging?pageSize={pageSize}&pageNumber={pageNumber}
```

#### `repositories/alumni_repository.dart`
```
Methods:
  Future<Result<List<Alumni>>> getAlumni({int pageSize = 10, int pageNumber = 1})
    GET /Alumni/GetAlumniDirectoryPaging?pageSize={pageSize}&pageNumber={pageNumber}

  Future<Result<List<Alumni>>> searchAlumni({String? name, String? passoutYear, String? degree, String? branch, String? membershipType, int pageSize = 10, int pageNumber = 1})
    GET /Alumni/SearchAlumni?name={}&passoutYear={}&degree={}&branch={}&membershipType={}&pageSize={}&pageNumber={}
```

#### `repositories/digital_download_repository.dart`
```
Methods:
  Future<Result<List<DigitalDownload>>> getByCategory(DownloadCategory category, {int pageSize = 10, int pageNumber = 1})
    GET /DigitalDownload?{category.apiParam}&pageSize={pageSize}&pageNumber={pageNumber}

  Future<Result<DigitalDownload>> getById(String id)
    GET /DigitalDownload/{id}
```

#### `repositories/profile_repository.dart`
```
Constructor takes ApiClient AND SecureStorageService.

Methods:
  Future<Result<Profile>> getProfile()
    Reads encId from secure storage.
    GET /alumni?EncryptedId={encId}
    Parse Result as Profile.

  Future<Result<void>> updateProfile(UpdateProfileRequest request)
    Reads encId + token from secure storage.
    POST /Alumni/Update?EncryptedId={encId}  (requiresAuth: true)
    Body: request.toJson()

  Future<Result<void>> uploadProfileImage(File imageFile)
    Multipart POST with image. (Implement as TODO stub for now.)
```

#### `repositories/master_repository.dart`
```
Methods:
  Future<Result<List<Country>>> getCountries()     → GET /Country
  Future<Result<List<LState>>> getStates(int countryId) → GET /State?CountryId={countryId}
  Future<Result<List<City>>> getCities(int stateId)     → GET /City?StateId={stateId}
  Future<Result<List<Branch>>> getBranches()         → GET /Branch
  Future<Result<List<Program>>> getPrograms()        → GET /Program
  Future<Result<List<MembershipType>>> getMembershipTypes() → GET /MembershipType

  Future<Result<void>> updateMembershipType(String encId, int membershipId)
    PUT /Alumni/ChangeMembershipRequest/{encId}/{membershipId} (requiresAuth: true)
```

---

### CONTROLLER LAYER

Every controller: extends `ChangeNotifier`. Constructor takes required repositories. Has `LoadState _state` + getter. Has `String? _errorMessage` + getter. Calls `notifyListeners()` after every state change.

#### `controllers/theme_controller.dart`
```
State: ThemeMode _themeMode = ThemeMode.system
Methods: toggleTheme(), setThemeMode(ThemeMode)
```

#### `controllers/auth_controller.dart`
```
Constructor takes AuthRepository, SecureStorageService.

State: LoadState _loginState, AuthToken? _token

Methods:
  Future<bool> login(String email, String password)
    - Set loading. Call repo.login(). On success: store token in secure storage, call _fetchEncId(), return true.
    - On failure: set error, return false.
  
  Future<void> _fetchEncId()
    - Call repo.getEncId(). Store result in secure storage.

  Future<void> logout()
    - Clear secure storage. Reset state.

  Future<bool> isLoggedIn()
    - Check secure storage for access_token.
```

#### `controllers/home_controller.dart`
```
Constructor takes HomeRepository, NewsRepository, EventRepository, MediaRepository, NoteworthyRepository, DigitalDownloadRepository.

State:
  LoadState _sliderState, List<HomeSlider> _sliders = []
  LoadState _newsPreviewState, News? _latestNews
  LoadState _eventPreviewState, Event? _latestEvent
  LoadState _mediaPreviewState, MediaItem? _latestMedia
  LoadState _noteworthyPreviewState, Noteworthy? _latestNoteworthy
  LoadState _downloadPreviewState, DigitalDownload? _latestDownload

Methods:
  Future<void> fetchSliders() → calls homeRepo.getSliders()
  Future<void> fetchNewsPreview() → calls newsRepo.getNews(pageSize: 1, pageNumber: 1), takes first item
  Future<void> fetchEventPreview() → calls eventRepo.getEvents(pageSize: 1, pageNumber: 1), takes first item
  Future<void> fetchMediaPreview() → calls mediaRepo.getMedia(pageSize: 1, pageNumber: 1)
  Future<void> fetchNoteworthyPreview() → calls noteworthyRepo.getNoteworthy(pageSize: 1, pageNumber: 1)
  Future<void> fetchDownloadPreview() → calls downloadRepo.getByCategory(DownloadCategory.desktopWallpaper, pageSize: 1, pageNumber: 1)
  Future<void> init() → calls all fetch methods above
```

#### `controllers/news_controller.dart`
```
Constructor takes NewsRepository.

State: LoadState _state, List<News> _newsList = [], News? _selectedNews, int _currentPage = 1, bool _hasMore = true

Methods:
  Future<void> fetchNews() → page 1, set list. hasMore = result.length >= pageSize
  Future<void> loadMore() → increment page, append to list
  Future<void> fetchNewsById(String id) → sets _selectedNews
  void reset() → clear state
```

#### `controllers/event_controller.dart`
```
Constructor takes EventRepository.

State:
  LoadState _state
  List<Event> _upcomingEvents = [], List<Event> _pastEvents = []
  Event? _selectedEvent
  int _upcomingPage = 1, _pastPage = 1
  bool _hasMoreUpcoming = true, _hasMorePast = true

Methods:
  Future<void> fetchEvents() → gets events, splits by startDate vs DateTime.now()
  Future<void> loadMoreUpcoming() → paginate upcoming
  Future<void> loadMorePast() → paginate past
  Future<void> fetchEventById(String id) → sets _selectedEvent
```

#### `controllers/media_controller.dart`
```
Constructor takes MediaRepository.
State: LoadState, List<MediaItem>, currentPage, hasMore
Methods: fetchMedia(), loadMore()
```

#### `controllers/noteworthy_controller.dart`
```
Constructor takes NoteworthyRepository.
State: LoadState, List<Noteworthy>, currentPage, hasMore
Methods: fetchNoteworthy(), loadMore()
```

#### `controllers/alumni_controller.dart`
```
Constructor takes AlumniRepository.

State:
  LoadState _state
  List<Alumni> _alumniList = []
  int _currentPage = 1, bool _hasMore = true
  bool _isSearchMode = false
  String? _searchName, _searchYear, _searchDegree, _searchBranch, _searchMembershipType

Methods:
  Future<void> fetchAlumni() → default paginated fetch
  Future<void> searchAlumni({name, year, degree, branch, membershipType}) → sets search mode + params, fetches page 1
  Future<void> loadMore() → if search mode, search with current params; else default fetch
  void clearSearch() → reset search params and mode, refetch
```

#### `controllers/digital_download_controller.dart`
```
Constructor takes DigitalDownloadRepository.

State:
  Map<DownloadCategory, LoadState> _categoryStates (initialize all to initial)
  Map<DownloadCategory, List<DigitalDownload>> _categoryData (initialize all to [])
  Map<DownloadCategory, int> _categoryPages (initialize all to 1)
  Map<DownloadCategory, bool> _categoryHasMore (initialize all to true)
  DigitalDownload? _selectedDownload

Methods:
  Future<void> fetchCategory(DownloadCategory cat) → fetch page 1 for category
  Future<void> loadMore(DownloadCategory cat) → paginate category
  Future<void> fetchById(String id) → sets _selectedDownload
  Future<void> fetchAllCategories() → calls fetchCategory for each
```

#### `controllers/profile_controller.dart`
```
Constructor takes ProfileRepository, MasterRepository, SecureStorageService.

State:
  LoadState _profileState, LoadState _updateState, LoadState _masterDataState
  Profile? _profile
  bool _isEditMode = false
  List<Country> _countries, List<LState> _states, List<City> _cities
  List<Program> _programs, List<Branch> _branches, List<MembershipType> _membershipTypes
  Country? _selectedCountry, LState? _selectedState, City? _selectedCity
  Program? _selectedProgram, Branch? _selectedBranch

  // TextEditingControllers for all form fields
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final primaryAddressController = TextEditingController();
  final secondaryAddressController = TextEditingController();
  final emailController = TextEditingController();
  final pinCodeController = TextEditingController();
  final mobileController = TextEditingController();
  final telephoneController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final designationController = TextEditingController();
  final passoutYearController = TextEditingController();
  String _genderValue = 'Male';

Methods:
  Future<void> init() → calls fetchProfile() then loadMasterData()
  Future<void> fetchProfile() → profileRepo.getProfile() → populates TECs from profile data
  Future<void> updateProfile() → builds UpdateProfileRequest from TECs → profileRepo.updateProfile() → re-fetches profile
  Future<void> loadMasterData() → loads countries, programs, branches, membershipTypes
  Future<void> onCountryChanged(Country) → sets selected, loads states
  Future<void> onStateChanged(LState) → sets selected, loads cities
  void toggleEditMode() → flips _isEditMode
  void _populateControllers(Profile profile) → fills all TECs + dropdown selections from profile

  @override dispose() → dispose all TextEditingControllers
```

---

### THEME LAYER

#### `theme/app_colors.dart`
```
class AppColors:
  Primary: Color(0xff3C4EC5)
  PrimaryDark: Color(0xff069DEF)
  ScaffoldLight: white
  ScaffoldDark: Color(0xff161616)
  CardLight: Color(0xfff0f0f0)
  CardDark: Color(0xff222327)
  TextPrimary: Color(0xff495057)
  TextSecondary: Color(0xff6c757d)
  LdceRed: Color(0xffCC0000)
  LdceNavy: Color(0xff021048)
  Success: Color(0xff28a745)
  Error: Color(0xffdc3545)
  Warning: Color(0xffffc107)
  Divider: Color(0xffe8e8e8)
```

#### `theme/app_spacing.dart`
```
class AppSpacing:
  xs = 4.0, sm = 8.0, md = 16.0, lg = 24.0, xl = 32.0, xxl = 48.0
  screenPadding = EdgeInsets.all(16.0)
  cardPadding = EdgeInsets.all(12.0)
  borderRadius = 12.0
  cardBorderRadius = 8.0
```

#### `theme/app_text_styles.dart`
```
class AppTextStyles — using Google Fonts Montserrat:
  headlineLarge, headlineMedium, headlineSmall
  titleLarge, titleMedium, titleSmall
  bodyLarge, bodyMedium, bodySmall
  labelLarge, labelMedium
```

#### `theme/app_theme.dart`
```
class AppTheme:
  static ThemeData get light → full ThemeData (brightness, colors, appBar, card, tab, checkbox, radio, switch, FAB, divider, etc.)
  static ThemeData get dark → dark variant
  Font family: Montserrat
```

---

### SHARED WIDGETS

#### `views/widgets/app_scaffold.dart`
```
Stateless widget. Provides consistent Scaffold with CustomAppBar + AppDrawer.
Props: title (String), body (Widget), showProfile (bool), bottom (PreferredSizeWidget?), floatingActionButton (Widget?)
```

#### `views/widgets/custom_app_bar.dart`
```
Implements PreferredSizeWidget.
Props: title (String), scaffoldKey (GlobalKey<ScaffoldState>?), bottom (PreferredSizeWidget?), showProfile (bool)
UI: Semi-transparent black AppBar. Leading: logo + "LDCE Connect" (tap → /home). Actions: profile CircleAvatar (if logged in, from ProfileController) + hamburger menu button.
Reads auth state from AuthController via Consumer.
```

#### `views/widgets/app_drawer.dart`
```
StatefulWidget.
Reads auth state to show Profile/Login dynamically.
Navigation items (each as ListTile):
  - Profile (if logged in) → /profile
  - Login (if not logged in) → /login
  - Home → /home
  - Events → /events
  - Media Gallery → /media
  - Alumni Directory → /alumni-directory
  - Projects (expandable: Tree Plantation, AT Hackathon)
  - Noteworthy Mentions → /noteworthy
  - Digital Downloads → /downloads
  - News → /news
  - About Us (expandable: About, Membership Types)
  - Logout (if logged in) → clear storage, navigate /home
Footer: app version from package_info_plus.
```

#### `views/widgets/content_card.dart`
```
Stateless. Props: imageUrl, title, description, onTap, width.
UI: InkWell → Container (rounded border) → Column [CachedImage, title Text, description Text]
```

#### `views/widgets/news_card.dart`
```
Stateless. Props: news (News), onTap.
UI: Card with cover image, date, title, short description.
```

#### `views/widgets/event_card.dart`
```
Stateless. Props: event (Event), onTap.
UI: Card with cover image, date range, title, venue.
```

#### `views/widgets/alumni_card.dart`
```
Stateless. Props: alumni (Alumni).
UI: ExpansionTile showing name + year, expanding to show program, branch, membership, profession.
```

#### `views/widgets/download_card.dart`
```
Stateless. Props: download (DigitalDownload), onTap.
UI: Card with file preview/icon, title, category badge.
```

#### `views/widgets/image_gallery.dart`
```
StatefulWidget. Props: images (List<String>), imageTag (String).
UI: PageView showing images + horizontal thumbnail row below. Tapping thumbnail changes page. Tapping image opens FullImageViewer.
```

#### `views/widgets/full_image_viewer.dart`
```
Stateless. Props: imageUrl, imageTag, backgroundOpacity.
UI: Full-screen overlay with semi-transparent background. InteractiveViewer for pinch-to-zoom. Tap to close (Navigator.pop). Hero animation with imageTag.
```

#### `views/widgets/loading_shimmer.dart`
```
Stateless. Uses shimmer package.
Variants via named constructors: LoadingShimmer.list(), LoadingShimmer.card(), LoadingShimmer.detail()
```

#### `views/widgets/app_error_widget.dart`
```
Stateless. Props: message (String), onRetry (VoidCallback).
UI: Centered Column → error icon + message Text + "Retry" ElevatedButton.
```

#### `views/widgets/empty_state_widget.dart`
```
Stateless. Props: message (String, default "No data found").
UI: Centered Column → empty icon + message Text.
```

#### `views/widgets/pagination_loader.dart`
```
Stateless. UI: Center → Padding → CircularProgressIndicator. Placed at bottom of lists during loadMore.
```

#### `views/widgets/section_header.dart`
```
Stateless. Props: title (String), onViewAll (VoidCallback?).
UI: Row → title Text (left, bold) + "View All >" TextButton (right, if onViewAll provided).
```

#### `views/widgets/html_content.dart`
```
Stateless. Props: htmlString (String).
Wraps flutter_html's Html widget with default styling.
```

#### `views/widgets/cached_image.dart`
```
Stateless. Props: imageUrl (String), width, height, fit, borderRadius.
Wraps CachedNetworkImage with CircularProgressIndicator placeholder and error icon.
Handles null/empty imageUrl gracefully with placeholder.
```

#### `views/widgets/custom_dropdown.dart`
```
Stateless generic widget. Props: items (List<T>), selectedValue (T?), onChanged, hint, itemLabel (String Function(T)).
Wraps DropdownButton2 with consistent styling.
```

---

### VIEW LAYER (SCREENS)

Every screen should:
- Use `AppScaffold` for layout consistency (except splash, login, error screens)
- Consume its controller via `Consumer<XController>`
- Handle all LoadStates: initial/loading → `LoadingShimmer`, error → `AppErrorWidget(onRetry:)`, loaded → actual content
- Use GoRouter for navigation: `context.go()`, `context.push()`

#### `views/splash/splash_screen.dart`
```
StatefulWidget. On initState: check auth token, delay 2s, navigate to /home.
UI: Centered logo + app name + CircularProgressIndicator.
```

#### `views/auth/login_screen.dart`
```
StatefulWidget (for TextEditingControllers).
Consumer<AuthController>.
UI: SafeArea → SingleChildScrollView → Column → logo, email field, password field (with visibility toggle), login button.
Validation: email required + valid format, password required + min 6 chars.
On submit: call authController.login(). On success → context.go('/home'). On failure → show SnackBar.
```

#### `views/home/home_screen.dart`
```
StatefulWidget (for TabController with SingleTickerProviderStateMixin).
Consumer<HomeController>.
UI: AppScaffold → Column:
  - CarouselSlider from homeController.sliders
  - "ALUMNI DIRECTORY" banner button → navigates to /alumni-directory
  - TabBar (7 colored tabs: Home, News, Events, Media, Noteworthy, Projects, Downloads)
  - TabBarView with 7 tab widgets
Firebase notification handling in initState:
  - FirebaseMessaging.instance.getInitialMessage() → route based on data type
  - FirebaseMessaging.onMessageOpenedApp.listen → route based on data type
```

#### `views/home/tabs/home_tab.dart`
```
Stateless. Static "Welcome to LDCE Connect" content with mission statement.
No controller needed.
```

#### `views/home/tabs/news_tab.dart`
```
Consumer<HomeController>.
Shows latest news preview (latestNews) using NewsCard + SectionHeader("News", onViewAll: → /news).
Handles loading/error/loaded states.
```

#### `views/home/tabs/events_tab.dart`
```
Consumer<HomeController>.
Shows latest event preview using EventCard + SectionHeader("Events", onViewAll: → /events).
```

#### `views/home/tabs/media_tab.dart`
```
Consumer<HomeController>.
Shows latest media preview using ContentCard + SectionHeader("Media", onViewAll: → /media).
```

#### `views/home/tabs/noteworthy_tab.dart`
```
Consumer<HomeController>.
Shows latest noteworthy using ContentCard + SectionHeader("Noteworthy Mentions", onViewAll: → /noteworthy).
```

#### `views/home/tabs/downloads_tab.dart`
```
Consumer<HomeController>.
Shows latest download using DownloadCard + SectionHeader("Digital Downloads", onViewAll: → /downloads).
```

#### `views/home/tabs/projects_tab.dart`
```
Stateless. Shows two project cards (Tree Plantation, AT Hackathon) linking to their detail screens.
```

#### `views/news/news_list_screen.dart`
```
StatefulWidget (for ScrollController).
Consumer<NewsController>.
AppScaffold with title "News".
ListView.builder with NewsCard items. Infinite scroll: on scroll near bottom → newsController.loadMore().
Bottom: PaginationLoader when state == loadingMore.
```

#### `views/news/news_detail_screen.dart`
```
Screen receives news data via constructor or extra params from GoRouter.
Props: title, imageUrl, date, description (HTML), attachments.
UI: AppScaffold → ListView → cover image + date + title + HtmlContent + ImageGallery (if attachments).
Navigation buttons: Home, All News.
```

#### `views/events/event_list_screen.dart`
```
StatefulWidget (for TabController, 2 tabs: Upcoming, Past).
Consumer<EventController>.
AppScaffold with TabBar bottom.
Two tab views, each a ListView.builder with EventCard + infinite scroll.
```

#### `views/events/event_detail_screen.dart`
```
Screen receives event data. 
UI: AppScaffold → ListView → cover image + dates + title + venue + contactPerson + HtmlContent + ImageGallery.
```

#### `views/media/media_list_screen.dart`
```
Consumer<MediaController>. ListView.builder + infinite scroll with ContentCard items.
```

#### `views/media/media_detail_screen.dart`
```
Receives media data. Shows title + description + ImageGallery of all images. Full image viewer on tap.
```

#### `views/noteworthy/noteworthy_list_screen.dart`
```
Consumer<NoteworthyController>. ListView.builder + infinite scroll with AlumniCard-style items.
```

#### `views/noteworthy/noteworthy_detail_screen.dart`
```
Receives noteworthy data. Shows cover photo + alumni info + title + HtmlContent.
```

#### `views/alumni/alumni_directory_screen.dart`
```
StatefulWidget.
Consumer<AlumniController>.
AppScaffold → Column:
  - Search TextField
  - Row of 3 CustomDropdowns: Program (B.E./M.E./MCA), Branch (varies by program), Year (1951–2028)
  - Search button
  - ListView of AlumniCard items
  - Row: Previous / Next page buttons
The branch dropdown content changes based on selected program (B.E. has different branches than M.E.).
```

#### `views/downloads/downloads_screen.dart`
```
StatefulWidget (for TabController, 5 tabs matching DownloadCategory enum).
Consumer<DigitalDownloadController>.
AppScaffold with TabBar bottom.
Each tab: ListView.builder of DownloadCard items + infinite scroll per category.
```

#### `views/downloads/download_detail_screen.dart`
```
Receives download data. Shows title + description + file preview/download link.
```

#### `views/profile/profile_screen.dart`
```
StatefulWidget.
Consumer<ProfileController>.
AppScaffold.
4 form sections (each in a Card with ExpansionTile or always visible):
  1. Personal Info: first/middle/last name, DOB (date picker), gender (radio)
  2. Academic Info: program dropdown, branch dropdown, passout year (year picker)
  3. Contact Info: country → state → city cascading dropdowns, address fields, email, phone
  4. Company Info: company name, address, designation
Profile picture: CircleAvatar + edit button → ImagePicker → upload
Toggle edit/view mode with FAB or AppBar action button.
Save button calls profileController.updateProfile().
Max 300 lines for this file — extract each section as a private widget method or separate widget file.
```

#### `views/projects/tree_plantation_screen.dart`
```
Static content page. AppScaffold. Card with project description, images, external links via url_launcher.
```

#### `views/projects/at_hackathon_screen.dart`
```
Static content page. Same structure as tree_plantation.
```

#### `views/general/about_screen.dart`
```
Static content page about LDCE Alumni Association (est. 1996). AppScaffold + ScrollView.
```

#### `views/general/membership_types_screen.dart`
```
Static content page explaining membership types + link to https://www.ldcealumni.net/Home/Registration via url_launcher.
```

#### `views/error/no_internet_screen.dart`
```
Centered: wifi-off icon + "No Internet Connection" message + "Try Again" button.
Retry: check connectivity, if connected → context.go('/home').
```

#### `views/error/error_screen.dart`
```
Centered: error icon + "Something Went Wrong" message + "Try Again" button.
Retry → context.go('/home').
```

---

### EXTENSIONS

#### `extensions/build_context_extensions.dart`
```
extension BuildContextX on BuildContext:
  ThemeData get theme => Theme.of(this)
  TextTheme get textTheme => Theme.of(this).textTheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme
  MediaQueryData get mediaQuery => MediaQuery.of(this)
  double get screenWidth => MediaQuery.of(this).size.width
  double get screenHeight => MediaQuery.of(this).size.height
  void showSnackBar(String message) => ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)))
```

#### `extensions/string_extensions.dart`
```
extension StringX on String:
  bool get isValidEmail → regex check
  String get capitalize → first letter uppercase
  String get initials → first letter of each word
```

#### `extensions/date_extensions.dart`
```
extension DateTimeX on DateTime:
  String get displayFormat → 'dd MMM yyyy'
  String get timeFormat → 'hh:mm a'
  bool get isFutureDate → isAfter(DateTime.now())
  bool get isPastDate → isBefore(DateTime.now())
```

#### `extensions/widget_extensions.dart`
```
extension WidgetX on Widget:
  Widget paddingAll(double value) → Padding(padding: EdgeInsets.all(value), child: this)
  Widget paddingSymmetric({double h = 0, double v = 0})
  Widget paddingOnly({double l, double r, double t, double b})
  Widget centered() → Center(child: this)
  Widget expanded({int flex = 1}) → Expanded(flex: flex, child: this)
```

---

### ENTRY POINT

#### `main.dart`
```dart
// 1. WidgetsFlutterBinding.ensureInitialized()
// 2. Firebase.initializeApp()
// 3. FirebaseMessaging.onBackgroundMessage(_backgroundHandler)  
// 4. Request notification permissions
// 5. Subscribe to FCM topics: 'all-android'/'all-ios' per platform, debug topics in kDebugMode
// 6. SystemChrome.setPreferredOrientations([portraitUp, portraitDown])
// 7. Determine config: kDebugMode ? AppConfig.dev : AppConfig.prod
// 8. Create SecureStorageService
// 9. Create ApiClient(config, secureStorage)
// 10. Create all repositories (passing apiClient, secureStorage as needed)
// 11. runApp(ProviderConfig.wrap(App(), repositories...))

// Top-level background handler:
@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
```

#### `app.dart`
```dart
class App extends StatelessWidget {
  // Consumer<ThemeController> → MaterialApp.router(
  //   routerConfig: AppRouter.router,
  //   theme: AppTheme.light,
  //   darkTheme: AppTheme.dark,
  //   themeMode: themeController.themeMode,
  //   debugShowCheckedModeBanner: false,
  //   localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
  //   supportedLocales: [Locale('en'), Locale('hi'), Locale('ar'), Locale('fr'), Locale('zh')],
  // )
}
```

---

## IMPORTANT CONSTRAINTS

1. **Every file must compile.** No placeholder `// TODO` without a valid stub. Every method must have a body, even if it's a minimal implementation.
2. **Max 300 lines per file.** Split large screens into private widget methods or separate files.
3. **No `print()`.** Use `AppLogger`.
4. **No `dynamic` except in JSON parsing boundary** (fromJson methods).
5. **No commented-out code.**
6. **All public members documented with `///` doc comments.**
7. **Use `const` constructors wherever possible.**
8. **Dart file names: `snake_case.dart`.** No spaces, no capitals, no double dots.
9. **Run `flutter analyze` with zero warnings/errors** after completion.
10. **All imports use package imports** (`package:ldce_alumni_v2/...`), not relative.

---

## VERIFICATION CHECKLIST

After creating all files, verify:
- [ ] `flutter pub get` succeeds
- [ ] `flutter analyze` has zero errors
- [ ] All routes are defined and point to real screens
- [ ] All providers are registered in ProviderConfig
- [ ] All controllers have their repositories injected
- [ ] All repositories use ApiClient (not direct http calls)
- [ ] All models have fromJson + toJson
- [ ] Every screen handles loading, error, and loaded states
- [ ] AppDrawer has all navigation items wired
- [ ] Total file count ≈ 90-100 files

---

*This prompt version: 1.0 | Generated: March 2026*
