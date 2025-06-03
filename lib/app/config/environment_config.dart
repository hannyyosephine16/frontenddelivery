enum Environment { development, staging, production }

class EnvironmentConfig {
  static Environment _environment = Environment.development;

  static Environment get environment => _environment;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;

  // API Base URLs
  static String get baseUrl {
    switch (_environment) {
      case Environment.development:
        return 'http://localhost:6100/api/v1';
      case Environment.staging:
        return 'https://staging.delpick.horas-code.my.id/api/v1';
      case Environment.production:
        return 'https://delpick.horas-code.my.id/api/v1';
    }
  }

  // WebSocket URLs
  static String get socketUrl {
    switch (_environment) {
      case Environment.development:
        return 'ws://localhost:6100';
      case Environment.staging:
        return 'wss://staging.delpick.horas-code.my.id';
      case Environment.production:
        return 'wss://delpick.horas-code.my.id';
    }
  }

  // File upload URLs
  static String get uploadUrl {
    switch (_environment) {
      case Environment.development:
        return 'http://localhost:6100/uploads';
      case Environment.staging:
        return 'https://staging.delpick.horas-code.my.id/uploads';
      case Environment.production:
        return 'https://delpick.horas-code.my.id/uploads';
    }
  }

  // Logging settings
  static bool get enableLogging {
    switch (_environment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return true;
      case Environment.production:
        return false;
    }
  }

  // Debug settings
  static bool get enableDebugMode {
    switch (_environment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return false;
      case Environment.production:
        return false;
    }
  }

  // Analytics settings
  static bool get enableAnalytics {
    switch (_environment) {
      case Environment.development:
        return false;
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }

  // Crash reporting settings
  static bool get enableCrashReporting {
    switch (_environment) {
      case Environment.development:
        return false;
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }
}