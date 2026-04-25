import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../providers/onboarding_provider.dart';

class CountryScreen extends ConsumerStatefulWidget {
  const CountryScreen({super.key});

  @override
  ConsumerState<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends ConsumerState<CountryScreen> {
  String selectedCountry = 'kenya';

  static const _countries = [
    _Country(code: 'kenya', name: 'Kenya', flag: '🇰🇪', active: true),
    _Country(code: 'uganda', name: 'Uganda', flag: '🇺🇬', active: false),
    _Country(code: 'rwanda', name: 'Rwanda', flag: '🇷🇼', active: false),
    _Country(code: 'tanzania', name: 'Tanzania', flag: '🇹🇿', active: false),
    _Country(code: 'south_sudan', name: 'South Sudan', flag: '🇸🇸', active: false),
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
                  const SizedBox(width: 8),
                  Expanded(child: _buildProgressSegment(false)),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                'Where are you\nlocated?',
                style: GoogleFonts.inter(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onboardingTextPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select your country to get local food recommendations',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.separated(
                  itemCount: _countries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    final isSelected = selectedCountry == country.code;
                    return GestureDetector(
                      onTap: country.active
                          ? () => setState(() => selectedCountry = country.code)
                          : null,
                      child: Opacity(
                        opacity: country.active ? 1.0 : 0.45,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.onboardingCardBorder
                                  : Colors.white.withValues(alpha: 0.1),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                country.flag,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      country.name,
                                      style: GoogleFonts.inter(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (!country.active) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        'Coming soon',
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: AppColors.onboardingTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Container(
                                width: 22,
                                height: 22,
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
                                          width: 11,
                                          height: 11,
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
                    onPressed: () {
                      ref.read(onboardingProvider.notifier).setCountry(selectedCountry);
                      Navigator.pushNamed(context, '/location');
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

class _Country {
  final String code;
  final String name;
  final String flag;
  final bool active;

  const _Country({
    required this.code,
    required this.name,
    required this.flag,
    required this.active,
  });
}
