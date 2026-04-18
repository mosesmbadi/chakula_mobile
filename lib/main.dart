import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'modules/onboarding/name_screen.dart';
import 'modules/onboarding/country_screen.dart';
import 'modules/onboarding/location_screen.dart';
import 'modules/onboarding/budget_screen.dart';
import 'modules/auth/register_screen.dart';
import 'modules/main_shell.dart';
import 'modules/home/suggestion_screen.dart';
import 'providers/app_screen_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: ChakulaApp()));
}

class ChakulaApp extends StatelessWidget {
  const ChakulaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chakula',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeWrapper(),
        '/name': (context) => const NameScreen(),
        '/country': (context) => const CountryScreen(),
        '/location': (context) => const LocationScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/register': (context) => const RegisterScreen(),
        '/suggestion': (context) => const SuggestionScreen(),
      },
    );
  }
}

/// Smart home wrapper that routes to the correct screen based on app state
class HomeWrapper extends ConsumerWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appScreenAsync = ref.watch(appScreenProvider);

    return appScreenAsync.when(
      data: (screen) {
        if (screen is AuthenticatedScreen) {
          return const MainShell();
        } else if (screen is OnboardingScreen) {
          return const NameScreen();
        } else if (screen is AuthRegisterScreen) {
          return const MainShell();
        }
        return const MainShell(); // fallback
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}
