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
  // Check auth status
  final authState = ref.watch(authProvider);

  // Check onboarding completion
  final isarService = ref.watch(isarServiceProvider);
  final onboardingData = await isarService.getOnboardingData();
  final hasCompletedOnboarding =
      onboardingData != null &&
      onboardingData.name.isNotEmpty &&
      onboardingData.county.isNotEmpty &&
      onboardingData.dailyBudget > 0;

  // Decision tree
  if (authState is AuthAuthenticated) {
    // User is logged in
    return const AuthenticatedScreen();
  }

  // User is not authenticated
  if (hasCompletedOnboarding) {
    // Has onboarding data, ready to register
    return const AuthRegisterScreen();
  }

  // Needs to go through onboarding first
  return const OnboardingScreen();
});
