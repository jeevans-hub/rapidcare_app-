import 'package:flutter/foundation.dart';

/// API endpoint configuration for development and deployed builds.
class ApiConfig {
  ApiConfig._();

  static const String _configuredBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );

  static const String _emulatorBaseUrl = 'http://10.0.2.2:5000/api/v1';
  static const String _hostBaseUrl = 'http://localhost:5000/api/v1';

  /// Honors --dart-define=API_BASE_URL, otherwise uses development defaults.
  static String get baseUrl => _configuredBaseUrl.isNotEmpty
      ? _configuredBaseUrl
      : !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? _emulatorBaseUrl
      : _hostBaseUrl;
}
