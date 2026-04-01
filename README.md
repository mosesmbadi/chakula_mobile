# chakula_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



lib/
├── core/
│   ├── app_config.dart      # API URL + key via --dart-define, never hardcoded
│   └── api_client.dart      # Single HTTP client (auth headers, 401 refresh, timeouts)
├── data/
│   ├── models/
│   │   ├── user.dart        # Clean model, no tokens stored on it
│   │   └── meal.dart        # Meal model with toAcceptPayload()
│   └── repositories/
│       ├── auth_repository.dart             # register, getStoredUser, clearSession
│       └── recommendations_repository.dart  # fetchAll, acceptMeal, acceptDayPlan
└── providers/
    ├── auth_provider.dart            # AuthState sealed class (initializing/authenticated/unauthenticated)
    ├── onboarding_provider.dart      # Draft name/budget/goals during onboarding
    └── recommendations_provider.dart # AsyncNotifier — loading/error/data handled automatically
