import 'package:flutter/foundation.dart';

class AppConfig {
  static const String _productionApiUrl = 'https://api.chakula.app';
  static const String _developmentApiUrl = 'http://10.0.2.2:3000';

  static const String _customBackendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: '',
  );

  static String get apiBaseUrl {
    if (_customBackendUrl.isNotEmpty) {
      return _customBackendUrl;
    }

    if (kReleaseMode) {
      return _productionApiUrl;
    }

    return _developmentApiUrl;
  }
}
