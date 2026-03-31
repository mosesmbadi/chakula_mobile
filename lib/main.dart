import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/app_colors.dart';
import 'core/user_provider.dart';
import 'modules/onboarding/name_screen.dart';
import 'modules/onboarding/location_screen.dart';
import 'modules/onboarding/budget_screen.dart';
import 'modules/main_shell.dart';

import 'modules/home/suggestion_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const ChakulaApp(),
    ),
  );
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
      initialRoute: '/name',
      routes: {
        '/name': (context) => const NameScreen(),
        '/location': (context) => const LocationScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/home': (context) => const MainShell(),
        '/suggestion': (context) => const SuggestionScreen(),
      },
    );
  }
}
