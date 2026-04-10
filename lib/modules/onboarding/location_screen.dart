import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../providers/onboarding_provider.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  String? selectedLocation = 'Nairobi CBD';

  final List<Map<String, String>> locations = [
    {
      'title': 'Nairobi CBD',
      'subtitle': 'Detected from your location',
      'region': 'kenya',
      'sub_region': 'nairobi',
    },
    {
      'title': 'Coast — Mombasa',
      'subtitle': 'Swahili cuisine region',
      'region': 'kenya',
      'sub_region': 'mombasa',
    },
    {
      'title': 'Kisumu lakeside',
      'subtitle': 'Luo fish dishes',
      'region': 'kenya',
      'sub_region': 'kisumu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildProgressSegment(true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildProgressSegment(true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildProgressSegment(false)),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                'Where are you\neating today?',
                style: GoogleFonts.inter(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onboardingTextPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We use this to find foods in your area',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: locations.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = locations[index];
                    final isSelected = selectedLocation == item['title'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLocation = item['title'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.onboardingCardBorder
                                : Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['subtitle']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: AppColors.onboardingTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.onboardingCardBorder
                                      : Colors.white.withValues(alpha: 0.2),
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.onboardingCardBorder,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      final selected = locations.firstWhere(
                        (l) => l['title'] == selectedLocation,
                      );
                      ref.read(onboardingProvider.notifier).setLocation(
                            region: selected['region']!,
                            subRegion: selected['sub_region']!,
                          );
                      Navigator.pushNamed(context, '/budget');
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
