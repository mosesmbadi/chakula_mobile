import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../core/counties_data.dart';
import '../../providers/onboarding_provider.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  String? selectedLocation = 'Nairobi';
  late TextEditingController searchController;
  late List<String> filteredCounties;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredCounties = CountiesData.getCountyNames();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterCounties(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCounties = CountiesData.getCountyNames();
      } else {
        filteredCounties = CountiesData.getCountyNames()
            .where((county) =>
                county.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
                'Select your county to find foods in your area',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 32),
              // Search Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: _filterCounties,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search county...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.onboardingTextSecondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.onboardingTextSecondary,
                    ),
                    suffixIcon: searchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              searchController.clear();
                              _filterCounties('');
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.onboardingTextSecondary,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Found ${filteredCounties.length} counties',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredCounties.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No counties found',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: AppColors.onboardingTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.onboardingTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredCounties.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final county = filteredCounties[index];
                          final isSelected = selectedLocation == county;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLocation = county;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.onboardingCardBorder
                                      : Colors.white.withValues(alpha: 0.1),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.onboardingCardBorder
                                            : Colors.white
                                                .withValues(alpha: 0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Center(
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration:
                                                  const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors
                                                    .onboardingCardBorder,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      county,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: selectedLocation == null
                        ? null
                        : () {
                            ref.read(onboardingProvider.notifier).setLocation(
                                  county: selectedLocation!,
                                  region: ref.read(onboardingProvider).country,
                                  subRegion: selectedLocation!
                                      .toLowerCase()
                                      .replaceAll(' ', '_'),
                                );
                            Navigator.pushNamed(context, '/budget');
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedLocation == null
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : AppColors.primary,
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
