/// Environment Configuration for LDCE Connect
///
/// This file centralizes all environment-dependent configuration values.
/// Switch between environments by changing the active [Environment] value.
///
/// Usage:
///   import 'package:ldce_alumni/config/env_config.dart';
///   final url = EnvConfig.apiBaseUrl;

enum Environment {
  development,
  staging,
  production,
}

class EnvConfig {
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // ACTIVE ENVIRONMENT — Change this to switch environments
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const Environment currentEnvironment = Environment.development;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // API Configuration
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static String get apiBaseUrl {
    switch (currentEnvironment) {
      case Environment.development:
        return 'https://ldcealumniapi.devitsandbox.com/api/';
      case Environment.staging:
        return 'https://ldcealumniapi.devitsandbox.com/api/';
      case Environment.production:
        return 'http://api.ldcealumni.net/api/';
    }
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // HTTP Configuration
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const int httpTimeout = 40; // seconds

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Firebase Configuration
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String firebaseProjectId = 'ldce-alumni-bd8d4';
  static const String firebaseStorageBucket = 'ldce-alumni-bd8d4.appspot.com';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // FCM Topics
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String fcmTopicAll = 'all';
  static const String fcmTopicAndroid = 'all-android';
  static const String fcmTopicIOS = 'all-ios';
  static const String fcmTopicDev = 'all-dhrumil';
  static const String fcmTopicDevSandbox = 'all-dhrumil-b-sandbox';
  static const String fcmTopicDevTest = 'all-dhrumil-dev-11';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // App Metadata
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String appName = 'LDCE Connect';
  static const String appPackage = 'net.ldcealumni';
  static const String appVersion = '1.0.5';
  static const int appBuildNumber = 7;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Secure Storage Configuration
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String secureStorageName = 'KwikBill';
  static const String secureStoragePrefix = 'kbca_';

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Feature Flags
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static bool get isProduction => currentEnvironment == Environment.production;
  static bool get isDevelopment => currentEnvironment == Environment.development;
  static bool get enableDebugLogs => !isProduction;
  static bool get enableDevTopics => isDevelopment;
}
