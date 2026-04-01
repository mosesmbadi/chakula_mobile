class AppConfig {
  // Inject at build time:
  // flutter run --dart-define=API_BASE_URL=https://api.yourapp.com --dart-define=API_KEY=your_key
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api',
  );

  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );
}
