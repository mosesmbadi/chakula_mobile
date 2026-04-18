import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_colors.dart';
import '../../data/models/meal.dart';
import '../../providers/auth_provider.dart';
import '../../providers/recommendations_provider.dart';
import '../../widgets/app_toast.dart';
import '../auth/login_screen.dart';
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
  int _swapIndex = 0;

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
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.onboardingBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (_) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Save your meal',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create an account or log in to track what you eat.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.onboardingTextSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Register Now',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return isAuth;
  }

  Future<void> _acceptCurrentMeal(Meal meal) async {
    if (!_requireAuth()) return;
    if (_isAccepting) return;

    final userCost = await _promptForUserCost(meal);
    if (!mounted) return;

    final imagePath = await _promptForPhoto();
    if (!mounted) return;

    setState(() => _isAccepting = true);
    final error = await ref
        .read(recommendationsProvider.notifier)
        .acceptMeal(_mealType, [meal], userCost: userCost, imagePath: imagePath);
    if (!mounted) return;
    setState(() => _isAccepting = false);

    AppToast.show(
      context,
      error == null ? '${_mealType[0].toUpperCase()}${_mealType.substring(1)} accepted!' : 'Could not accept meal. Please try again.',
      type: error == null ? ToastType.success : ToastType.error,
    );
  }

  Future<int?> _promptForUserCost(Meal meal) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _UserCostSheet(meal: meal),
    );
  }

  Future<String?> _promptForPhoto() async {
    String? imagePath;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetCtx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a photo?',
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'Optionally attach a photo of your meal.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: Text('Camera', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () async {
                      final picked = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 85);
                      imagePath = picked?.path;
                      if (sheetCtx.mounted) Navigator.pop(sheetCtx);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_library_outlined),
                    label: Text('Gallery', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () async {
                      final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
                      imagePath = picked?.path;
                      if (sheetCtx.mounted) Navigator.pop(sheetCtx);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(sheetCtx),
                child: Text('Skip', style: GoogleFonts.inter(fontSize: 15, color: AppColors.textSecondary)),
              ),
            ),
          ],
        ),
      ),
    );
    return imagePath;
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
                  onTap: () => setState(() {
                    _mealType = type;
                    _swapIndex = 0;
                  }),
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
                    : _buildFeaturedCard(
                        currentFoods,
                        allFoods ?? {},
                      ),
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
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildFeaturedCard(List<Meal> foods, Map<String, List<Meal>> allFoods) {
    final food = foods[_swapIndex % foods.length];
    final location = food.commonAt.isNotEmpty ? food.commonAt.first : 'kenya';
    final canSwap = foods.length > 1;

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
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _isAccepting
                      ? null
                      : () => _acceptCurrentMeal(food),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: _isAccepting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'Accept this meal',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              if (canSwap) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => setState(() => _swapIndex++),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.swap_horiz, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'Swap',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (canSwap) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(foods.length, (i) {
                final active = i == _swapIndex % foods.length;
                return Container(
                  width: active ? 16 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: active
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ],
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

class _UserCostSheet extends StatefulWidget {
  final Meal meal;
  const _UserCostSheet({required this.meal});

  @override
  State<_UserCostSheet> createState() => _UserCostSheetState();
}

class _UserCostSheetState extends State<_UserCostSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.meal.priceMinKes.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How much did you pay?',
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            'Listed price is KSh ${widget.meal.priceMinKes}. Enter what you actually paid.',
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            decoration: InputDecoration(
              prefixText: 'KSh ',
              prefixStyle: GoogleFonts.inter(fontSize: 18, color: AppColors.textSecondary),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 2)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.accent, width: 2)),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: Colors.black.withValues(alpha: 0.15)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Skip', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, int.tryParse(_controller.text.trim())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Confirm', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
