---
name: chakula-mobile-workspace
description: "Workspace instructions for Chakula Mobile Flutter project. Use when: working on Chakula mobile app features, architecture decisions, or code reviews."
---

# Chakula Mobile - Workspace Instructions

## Project Overview

**Chakula Mobile** is a Flutter application for food discovery and recommendations. The app uses multiple flavors (development/production) with environment-specific configurations and JWT-based authentication.

### Key Technologies
- **Framework**: Flutter 3.x
- **Language**: Dart 3.10.7+
- **State Management**: Riverpod 2.6+
- **Storage**: Isar (local database), Flutter Secure Storage (tokens)
- **API Communication**: HTTP client with Bearer token auth
- **UI**: Material Design 3, Google Fonts, Flutter SVG

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── core/                     # Core utilities and config
│   ├── app_config.dart      # Backend URLs, environment config
│   ├── app_colors.dart      # Color scheme
│   ├── api_client.dart      # HTTP client with JWT auth
│   └── counties_data.dart   # Static county data
├── data/                     # Data layer (models, repos)
│   ├── local/               # Local database
│   ├── models/              # Data models
│   └── repositories/        # Data repositories
├── modules/                  # Feature modules
│   ├── auth/                # Authentication flow
│   ├── onboarding/          # User onboarding (name, location, budget)
│   ├── home/                # Home and main feed
│   ├── discover/            # Food discovery
│   ├── profile/             # User profile
│   └── log/                 # Admin/debug logs
├── providers/               # Riverpod state management
├── widgets/                 # Shared components
└── assets/                  # Images, fonts, brand assets
```

## Development Workflow

### Running the App

```bash
# Development (local backend)
flutter run --flavor development -t lib/main.dart

# Production (production backend)
flutter run --flavor production -t lib/main.dart

# With custom backend
flutter run --dart-define=BACKEND_URL=http://your-backend:3000
```

### Building for Play Store

```bash
# Build AAB for production
flutter build appbundle --flavor production --release

# Build APK for testing
flutter build apk --flavor development --release
```

### Backend Configuration

- **Development**: `http://127.0.0.1:3000` (local emulator)
- **Production**: `https://chakula-api.somastories.app`
- **Custom**: Pass `--dart-define=BACKEND_URL=...` at runtime

Backend URLs are defined in `lib/core/app_config.dart` and selected based on build flavor and `kReleaseMode`.

## Authentication Flow

### JWT Authentication
- Tokens stored securely in `FlutterSecureStorage`
- Bearer tokens passed in Authorization header: `Authorization: Bearer {token}`
- Automatic token refresh on 401 response
- No API key needed (JWT-only authentication)

### Token Storage Keys
- `access_token` - JWT for authenticated requests
- `refresh_token` - Used to obtain new access tokens

## Code Standards

### Dart/Flutter Style
- **Formatting**: Run `dart format .` before commits
- **Linting**: Follow Flutter lints defined in `analysis_options.yaml`
- **Naming**: camelCase for variables/functions, PascalCase for classes
- **Documentation**: Add doc comments to public APIs

### Riverpod Patterns
- Use `Provider` for simple values
- Use `StateNotifierProvider` for mutable state
- Place providers in `lib/providers/`
- Avoid mixing UI logic with state management

### Widget Best Practices
- Keep widgets focused and small
- Extract reusable components to `lib/widgets/`
- Use `const` constructors where possible
- Avoid deep nesting; extract smaller widgets

### API Client Usage
```dart
final apiClient = ref.read(apiClientProvider);
final response = await apiClient.get('/endpoint', authenticated: true);
```

## Common Tasks

### Adding a New Feature
1. Create feature folder under `lib/modules/{feature}/`
2. Add screens/widgets
3. Create data models in `lib/data/models/`
4. Add repository in `lib/data/repositories/`
5. Create provider in `lib/providers/`
6. Add route in `main.dart`

### Adding a New API Endpoint
1. Define model in `lib/data/models/`
2. Create repository method in `lib/data/repositories/`
3. Add provider in `lib/providers/` if needed
4. Use `apiClient.get()`, `apiClient.post()`, etc.

### Updating Backend URL
- Development/Production: Modify `app_config.dart` constants
- Runtime override: Use `--dart-define=BACKEND_URL=...`
- No need to rebuild; recompile and redeploy

### Local Development Setup
- Ensure backend is running on `http://localhost:3000`
- Emulator uses `http://10.0.2.2:3000` to reach host machine
- Use `flutter run --flavor development` for local testing

## Debugging Tips

### Check Current Backend
```dart
print(AppConfig.apiBaseUrl); // See which backend is active
```

### View Stored Tokens
```dart
final storage = const FlutterSecureStorage();
final token = await storage.read(key: 'access_token');
print(token);
```

### API Logs
- Enable verbose logging: `flutter run -v`
- HTTP requests/responses logged in `api_client.dart`

## File Organization When Coding

- **New feature screens**: `lib/modules/{feature}/`
- **Data models**: `lib/data/models/`
- **API repositories**: `lib/data/repositories/`
- **Reusable widgets**: `lib/widgets/`
- **State management**: `lib/providers/`
- **UI configuration**: `lib/core/`

## When Suggesting Changes

- Always follow the existing folder structure
- Respect the Riverpod + HTTP client pattern
- Update `pubspec.yaml` carefully (only add necessary dependencies)
- Keep flavors and backend configuration clean
- Ensure routes are registered in `main.dart`
- Test with both development and production flavors
