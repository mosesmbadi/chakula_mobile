import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../providers/onboarding_provider.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  double budget = 250;
  String selectedMealCount = '3 meals a day';

  final List<Map<String, String>> mealOptions = [
    {'title': '3 meals a day', 'subtitle': '~KSh 83 per meal'},
    {'title': '2 meals a day', 'subtitle': '~KSh 125 per meal'},
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
                  Expanded(child: _buildProgressSegment(true)),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                "What's your daily\nfood budget?",
                style: GoogleFonts.inter(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onboardingTextPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "We'll split this across your meals",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(
                      'KSh ${budget.toInt()}',
                      style: GoogleFonts.inter(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'per day · 3 meals',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.onboardingTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8,
                        activeTrackColor: AppColors.primary,
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                        thumbColor: AppColors.primary,
                        overlayColor: AppColors.primary.withValues(alpha: 0.2),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                        trackShape: const RoundedRectSliderTrackShape(),
                      ),
                      child: Slider(
                        value: budget,
                        min: 100,
                        max: 1000,
                        onChanged: (value) => setState(() => budget = value),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (budget - 100) / 900,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: mealOptions.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = mealOptions[index];
                    final isSelected = selectedMealCount == item['title'];
                    return GestureDetector(
                      onTap: () => setState(() => selectedMealCount = item['title']!),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.onboardingCardBorder
                                : Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title']!,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                  const SizedBox(height: 4),
                                  Text(item['subtitle']!,
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: AppColors.onboardingTextSecondary)),
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
                      ref.read(onboardingProvider.notifier).setBudget(budget.toInt());
                      Navigator.pushNamed(context, '/home');
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
                      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
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
        color: active ? AppColors.onboardingCardBorder : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
