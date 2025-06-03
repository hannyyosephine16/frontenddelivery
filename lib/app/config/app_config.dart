class AppConfig {
  static const String appName = 'DelPick';
  static const String appVersion = '1.0.0';
  // static const String appPackageName = 'com.delpick.fooddelivery';
  static const String appPackageName = 'frontend_delpick';


  // App settings
  static const int splashDuration = 3; // seconds
  static const int requestTimeout = 30; // seconds
  static const int maxRetryAttempts = 3;

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;

  // Location settings
  static const double defaultLatitude = 2.38349390603264; // IT Del coordinates
  static const double defaultLongitude = 99.14866498216043;
  static const double maxDeliveryRadius = 5.0; // kilometers

  // File upload settings
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];

  // Driver location update interval
  static const int locationUpdateInterval = 15; // seconds

  // Order settings
  static const int orderCancelTimeout = 15 * 60; // 15 minutes in seconds
  static const double serviceChargeRate = 0.1; // 10%

  // Rating settings
  static const int minRating = 1;
  static const int maxRating = 5;

  // Currency
  static const String currency = 'IDR';
  static const String currencySymbol = 'Rp';

  // Date formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Validation rules
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 100;
  static const int minNameLength = 3;
  static const int maxNameLength = 50;

  // Social media links
  static const String websiteUrl = 'https://delpick.com';
  static const String supportEmail = 'support@delpick.com';
  static const String privacyPolicyUrl = 'https://delpick.com/privacy';
  static const String termsOfServiceUrl = 'https://delpick.com/terms';
}