import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../providers/onboarding_provider.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[NameScreen] build');
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildProgressSegment(true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildProgressSegment(false)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildProgressSegment(false)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildProgressSegment(false)),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                "Welcome. What should we call you?",
                style: GoogleFonts.inter(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onboardingTextPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "We'll use this to personalize your experience",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _nameController,
                autofocus: true,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24, width: 2),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isNotEmpty) {
                        ref.read(onboardingProvider.notifier).setName(_nameController.text);
                        Navigator.pushNamed(context, '/country');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSegment(bool active) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: active
            ? AppColors.onboardingCardBorder
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
