import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'data/local/isar_service.dart';
import 'providers/auth_provider.dart';
import 'modules/onboarding/name_screen.dart';
import 'modules/onboarding/country_screen.dart';
import 'modules/onboarding/location_screen.dart';
import 'modules/onboarding/budget_screen.dart';
import 'modules/auth/login_screen.dart';
import 'modules/auth/register_screen.dart';
import 'modules/main_shell.dart';
import 'modules/home/suggestion_screen.dart';
import 'providers/app_screen_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[main] WidgetsFlutterBinding.ensureInitialized done');
  await IsarService.initialize();
  debugPrint('[main] IsarService.initialize done');
  runApp(const ProviderScope(child: ChakulaApp()));
  debugPrint('[main] runApp called');
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
        '/login': (context) => const LoginScreen(),
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
    final authState = ref.watch(authProvider);
    debugPrint('[HomeWrapper] build: authState=${authState.runtimeType}');

    // Hold on loading screen until auth check completes so we never
    // briefly flash NameScreen (dark background) for authenticated users.
    if (authState is AuthInitializing) {
      return const Scaffold(
        backgroundColor: Color(0xFF2C1207),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    // Auth resolved — now determine the correct screen.
    if (authState is AuthAuthenticated) {
      return const MainShell();
    }

    final appScreenAsync = ref.watch(appScreenProvider);
    return appScreenAsync.when(
      data: (screen) {
        if (screen is OnboardingScreen) return const NameScreen();
        return const MainShell(); // AuthRegisterScreen or fallback
      },
      // Auth is already resolved at this point; show NameScreen while Isar
      // loads onboarding data to avoid a second dark loading flash.
      loading: () => const NameScreen(),
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}
