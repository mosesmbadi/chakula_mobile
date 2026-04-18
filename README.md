# chakula_mobile

 Meal Generator App



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

## How to run:
flutter pub get
flutter run --flavor development