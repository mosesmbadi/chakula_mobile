import 'package:flutter/material.dart';

class AppColors {
  // -------------------------------------------------------------------------
  // Brand palette
  // -------------------------------------------------------------------------
  static const Color darkBrown      = Color(0xFF2C1207);
  static const Color brown          = Color(0xFF5C3215);
  static const Color lightBrown     = Color(0xFFC17D3C);
  static const Color ultraLightBrown = Color(0xFFE8A85C);
  static const Color green          = Color(0xFFA8C97F);
  static const Color red            = Color(0xFFFF0000);

  // -------------------------------------------------------------------------
  // Semantic aliases (mapped to brand palette)
  // -------------------------------------------------------------------------

  // Common
  static const Color primary  = ultraLightBrown;
  static const Color accent   = lightBrown;

  // Onboarding (dark)
  static const Color onboardingBackground  = darkBrown;
  static const Color onboardingCardBorder  = ultraLightBrown;
  static const Color onboardingTextPrimary = Colors.white;
  static const Color onboardingTextSecondary = Color(0xFF9E7C5D);

  // Main app (light)
  static const Color background     = Color(0xFFFEF9F3);
  static const Color textPrimary    = darkBrown;
  static const Color textSecondary  = Color(0xFF9E7C5D);
  static const Color cardBackground = Colors.white;

  // Progress / status
  static const Color protein    = green;
  static const Color iron       = Color(0xFFE6C94C);
  static const Color vitaminB12 = Color(0xFF62D1A2);

  // Toast
  static const Color toastWarning = ultraLightBrown;
  static const Color toastSuccess = green;
  static const Color toastError   = red;
}
