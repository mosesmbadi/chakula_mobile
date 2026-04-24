import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/isar_service.dart';
import '../data/repositories/auth_repository.dart';
import 'auth_provider.dart';
import 'onboarding_provider.dart';

/// Determines the current app screen to display based on auth and onboarding state
sealed class AppScreen {
  const AppScreen();
}

class AuthenticatedScreen extends AppScreen {
  const AuthenticatedScreen();
}

class OnboardingScreen extends AppScreen {
  const OnboardingScreen();
}

class AuthRegisterScreen extends AppScreen {
  const AuthRegisterScreen();
}

final appScreenProvider = FutureProvider<AppScreen>((ref) async {
  // By the time this provider is first watched, auth is already resolved
  // (HomeWrapper only watches this after the AuthInitializing guard passes).
  // Use ref.read so auth changes after login don't re-trigger this — HomeWrapper
  // handles the AuthAuthenticated case directly.
  final authState = ref.read(authProvider);

  if (authState is AuthAuthenticated) {
    return const AuthenticatedScreen();
  }

  // User is not authenticated — check onboarding completion.
  final isarService = ref.read(isarServiceProvider);
  final onboardingData = await isarService.getOnboardingData();
  final hasCompletedOnboarding =
      onboardingData != null &&
      onboardingData.name.isNotEmpty &&
      onboardingData.county.isNotEmpty &&
      onboardingData.dailyBudget > 0;

  if (hasCompletedOnboarding) {
    return const AuthRegisterScreen();
  }

  return const OnboardingScreen();
});
