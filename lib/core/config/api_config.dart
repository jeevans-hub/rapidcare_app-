import 'package:flutter/foundation.dart';

/// Central development API endpoint configuration.
class ApiConfig {
  ApiConfig._();

  static const String _emulatorBaseUrl = 'http://10.0.2.2:5000/api/v1';
  static const String _hostBaseUrl = 'http://localhost:5000/api/v1';

  /// Uses the Android emulator host alias on Android and localhost elsewhere.
  static String get baseUrl =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? _emulatorBaseUrl
          : _hostBaseUrl;
}
