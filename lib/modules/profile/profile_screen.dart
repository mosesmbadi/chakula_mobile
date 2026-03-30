import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Profile Screen',
          style: GoogleFonts.inter(
            fontSize: 24,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
