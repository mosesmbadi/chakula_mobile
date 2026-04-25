import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../auth/register_screen.dart';

class LogScreen extends ConsumerWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isAuthenticated = authState is AuthAuthenticated;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          '9:41',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isAuthenticated) ...[
                const SizedBox(height: 16),
                _buildRegisterBanner(context),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's log",
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '1,240 kcal',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NUTRITION TODAY',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildNutritionRow('Calories', 0.7, '1,240', AppColors.accent),
                    const SizedBox(height: 20),
                    _buildNutritionRow('Protein', 0.6, '44g', AppColors.protein,
                        delay: const Duration(milliseconds: 100)),
                    const SizedBox(height: 20),
                    _buildNutritionRow('Iron', 0.3, '4mg', AppColors.iron,
                        delay: const Duration(milliseconds: 200)),
                    const SizedBox(height: 20),
                    _buildNutritionRow('Vitamin B12', 0.5, '1.6mcg', AppColors.vitaminB12,
                        delay: const Duration(milliseconds: 300)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'MEALS EATEN',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              _buildMealEatenRow('Mandazi & Chai', '7:12 am · Breakfast', '340 kcal',
                  AppColors.primary.withValues(alpha: 0.1)),
              const Divider(height: 1),
              _buildMealEatenRow('Ugali Mayai + spinach', '1:05 pm · Lunch · customised',
                  '420 kcal', AppColors.vitaminB12.withValues(alpha: 0.1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionRow(
    String label,
    double progress,
    String value,
    Color color, {
    Duration delay = Duration.zero,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label,
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
        ),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              decoration:
                  BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
            )
                .animate(delay: delay)
                .custom(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (context, animValue, child) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: animValue * progress,
                    child: child,
                  ),
                ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 60,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealEatenRow(
      String title, String subtitle, String calories, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration:
                BoxDecoration(color: iconColor, borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(calories,
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.accent)),
        ],
      ),
    );
  }

  Widget _buildRegisterBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: Colors.black, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Register today',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                Text('And never lose your data',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: Colors.black.withValues(alpha: 0.7))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text('Join',
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
