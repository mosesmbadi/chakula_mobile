import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
  try {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('[main] WidgetsFlutterBinding.ensureInitialized done');
    
    try {
      await IsarService.initialize().timeout(
        const Duration(seconds: 5),
        onTimeout: () => debugPrint('[main] Isar initialization timed out'),
      );
      debugPrint('[main] IsarService.initialize done');
    } catch (e) {
      debugPrint('[main] Isar initialization error: $e');
    }

    runApp(const ProviderScope(child: ChakulaApp()));
    debugPrint('[main] runApp called');
  } catch (e, stack) {
    debugPrint('[main] CRITICAL ERROR: $e\n$stack');
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('Critical initialization error: $e'),
          ),
        ),
      ),
    ));
  }
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

class HomeWrapper extends ConsumerWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState is AuthInitializing) {
      return const Scaffold(
        backgroundColor: Color(0xFF2C1207),
        body: Skeletonizer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 40),
                SizedBox(height: 24),
                Text('Chakula Loading...'),
              ],
            ),
          ),
        ),
      );
    }

    if (authState is AuthAuthenticated) {
      return const MainShell();
    }

    final appScreenAsync = ref.watch(appScreenProvider);
    return appScreenAsync.when(
      data: (screen) {
        if (screen is OnboardingScreen) return const NameScreen();
        return const MainShell();
      },
      loading: () => const NameScreen(),
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}
