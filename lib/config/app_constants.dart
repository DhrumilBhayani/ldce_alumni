/// Application Constants for LDCE Connect
///
/// Centralized constant values used across the application.
/// Values that vary by environment should be in env_config.dart instead.

class AppConstants {
  AppConstants._(); // Prevent instantiation

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Pagination Defaults
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const int defaultPageSize = 5;
  static const int alumniPageSize = 25;
  static const int homePreviewSize = 1;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Secure Storage Keys
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String keyAccessToken = 'access_token';
  static const String keyEncryptedId = 'encId';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Route Names
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String routeHome = 'home';
  static const String routeEventsHome = 'events_home';
  static const String routeMediaHome = 'media_home';
  static const String routeNewsHome = 'news_home';
  static const String routeNoteworthyHome = 'noteworthy_home';
  static const String routeAlumniHome = 'alumni_directory_home';
  static const String routeDownloadsHome = 'downloads_home';
  static const String routeLogin = 'login';
  static const String routeProfile = 'profile';
  static const String routeAboutUs = 'about_us';
  static const String routeMembershipTypes = 'membership_types';
  static const String routeTreePlantation = 'tree_plantation';
  static const String routeAtHackathon = 'at_hackathon';
  static const String routeSingleNews = 'single_internet_news_screen';
  static const String routeSingleEvent = 'single_internet_events_screen';
  static const String routeSomethingWrong = 'something_wrong';
  static const String routeNoInternet = 'no_internet_screen';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // API Endpoints (relative to base URL)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String endpointLogin = 'Login';
  static const String endpointSlider = 'Slider';
  static const String endpointNewsPaging = 'News/GetNewsPaging';
  static const String endpointNewsById = 'News/';
  static const String endpointEventsPaging = 'Events/GetEventPaging';
  static const String endpointEventsById = 'Events/';
  static const String endpointAlumniPaging = 'Alumni/GetAlumniDirectoryPaging';
  static const String endpointAlumniSearch = 'Alumni/SearchAlumni';
  static const String endpointAlumniGetId = 'Alumni/GetId';
  static const String endpointAlumniProfile = 'alumni';
  static const String endpointMediaPaging = 'MediaGalleries/GetMediaGalleryPaging';
  static const String endpointAchievementsPaging = 'Achievements/GetAchievementPaging';
  static const String endpointDigitalDownload = 'DigitalDownload';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Digital Download Categories
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String categoryMobileSkin = 'Mobileskin';
  static const String categoryDesktopWallpaper = 'DesktopWallpaper';
  static const String categoryCalendar = 'Calendar';
  static const String categoryCampaignDownload = 'CampaignDownload';
  static const String categoryOtherMaterial = 'OtherMaterial';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Animation Durations
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const Duration pageAnimationDuration = Duration(milliseconds: 600);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Internet Check
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String internetCheckUrl = 'https://google.com';
  static const int internetCheckTimeout = 40; // seconds
}
