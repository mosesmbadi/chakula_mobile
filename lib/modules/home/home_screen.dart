import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../data/models/meal.dart';
import '../../providers/auth_provider.dart';
import '../../providers/recommendations_provider.dart';
import '../../widgets/app_toast.dart';
import '../auth/register_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _mealTypes = ['breakfast', 'lunch', 'dinner'];

  String _mealType = '';
  bool _isAccepting = false;

  @override
  void initState() {
    super.initState();
    _mealType = _currentMealType();
  }

  String _currentMealType() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) return 'breakfast';
    if (hour >= 11 && hour < 16) return 'lunch';
    return 'dinner';
  }

  String _mealTimeLabel(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return '7:00 AM';
      case 'lunch':
        return '12:00 PM';
      default:
        return '7:00 PM';
    }
  }

  bool _requireAuth() {
    final isAuth = ref.read(authProvider) is AuthAuthenticated;
    if (!isAuth) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    }
    return isAuth;
  }

  Future<void> _acceptCurrentMeal(Map<String, List<Meal>> allFoods) async {
    if (!_requireAuth()) return;
    final foods = allFoods[_mealType] ?? [];
    if (foods.isEmpty || _isAccepting) return;

    setState(() => _isAccepting = true);
    final error = await ref
        .read(recommendationsProvider.notifier)
        .acceptMeal(_mealType, foods);
    if (!mounted) return;
    setState(() => _isAccepting = false);

    AppToast.show(
      context,
      error == null ? '${_mealType[0].toUpperCase()}${_mealType.substring(1)} accepted!' : 'Could not accept meal. Please try again.',
      type: error == null ? ToastType.success : ToastType.error,
    );
  }

  Future<void> _acceptDayPlan(Map<String, List<Meal>> allFoods) async {
    if (!_requireAuth()) return;
    if (_isAccepting) return;
    setState(() => _isAccepting = true);

    final error = await ref
        .read(recommendationsProvider.notifier)
        .acceptDayPlan(allFoods);
    if (!mounted) return;
    setState(() => _isAccepting = false);

    AppToast.show(
      context,
      error == null ? "Today's plan accepted!" : 'Could not accept plan. Please try again.',
      type: error == null ? ToastType.success : ToastType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendationsAsync = ref.watch(recommendationsProvider);

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
          child: recommendationsAsync.when(
            loading: () => _buildContent(allFoods: null, isLoading: true),
            error: (e, _) => _buildContent(allFoods: null, error: e.toString()),
            data: (allFoods) => _buildContent(allFoods: allFoods),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({
    Map<String, List<Meal>>? allFoods,
    bool isLoading = false,
    String? error,
  }) {
    final currentFoods = allFoods?[_mealType] ?? [];
    final budget = allFoods != null
        ? (allFoods.values.expand((f) => f).fold<int>(0, (sum, f) => sum + f.priceMinKes) ~/
            (allFoods.values.expand((f) => f).length.clamp(1, 999)))
        : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          () {
            final auth = ref.watch(authProvider);
            if (auth is AuthAuthenticated) return 'Hello ${auth.user.name} 👋';
            return 'Hello Traveler 👋';
          }(),
          style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today's meals",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            if (allFoods != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'KSh $budget',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        // Meal type tabs
        if (allFoods != null) ...[
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _mealTypes.map((type) {
                final isSelected = _mealType == type;
                return GestureDetector(
                  onTap: () => setState(() => _mealType = type),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accent
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      type[0].toUpperCase() + type.substring(1),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],
        // Featured card
        isLoading
            ? _buildFeaturedCardSkeleton()
            : error != null
                ? _buildErrorCard(error)
                : currentFoods.isEmpty
                    ? _buildErrorCard('No recommendations found')
                    : _buildFeaturedCard(currentFoods.first),
        const SizedBox(height: 32),
        Text(
          'MORE OPTIONS',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: isLoading
              ? _buildSmallCardSkeletons()
              : currentFoods.length < 2
                  ? const SizedBox.shrink()
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int i = 1; i < currentFoods.length; i++) ...[
                          _buildSmallMealCard(
                            currentFoods[i].name,
                            'KSh ${currentFoods[i].priceMinKes}',
                            i == 1 ? AppColors.accent : AppColors.protein,
                          ),
                          if (i < currentFoods.length - 1) const SizedBox(width: 12),
                        ],
                      ],
                    ),
        ),
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: (isLoading || _isAccepting || allFoods == null)
                      ? null
                      : () => _acceptDayPlan(allFoods),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                  ),
                  child: _isAccepting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          "Accept today's plan",
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/suggestion'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                  ),
                  child: Text('Swap',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildFeaturedCard(Meal food) {
    final location = food.commonAt.isNotEmpty ? food.commonAt.first : 'kenya';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_mealType.toUpperCase()} · ${_mealTimeLabel(_mealType)}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'KSh ${food.priceMinKes}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            food.name,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$location · Kenya',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _isAccepting
                    ? null
                    : () => _acceptCurrentMeal(
                          ref.read(recommendationsProvider).value ?? {},
                        ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Accept this meal',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCardSkeleton() {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      width: double.infinity,
      height: 240,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          message,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSmallCardSkeletons() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildSmallMealCard('...', '...', AppColors.accent),
        const SizedBox(width: 12),
        _buildSmallMealCard('...', '...', AppColors.protein),
      ],
    );
  }

  Widget _buildSmallMealCard(String title, String price, Color iconColor) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const Spacer(),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
