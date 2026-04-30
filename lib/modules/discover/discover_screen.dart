import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/app_colors.dart';
import '../../data/models/meal_history_item.dart';
import '../../providers/meal_history_filter_provider.dart';
import '../../providers/meal_history_provider.dart';
import '../../widgets/app_toast.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      ref.read(mealHistoryProvider.notifier).loadMore();
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _FilterSheet(),
    );
  }

  void _showLogMealSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _LogMealSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealHistoryAsync = ref.watch(mealHistoryProvider);
    final filter = ref.watch(mealHistoryFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '420 pts',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Filter row
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterButton(filter),
                            if (filter.region != null) ...[
                              const SizedBox(width: 8),
                              _buildActiveChip(
                                filter.region!,
                                onRemove: () =>
                                    ref
                                        .read(
                                          mealHistoryFilterProvider.notifier,
                                        )
                                        .state = filter.copyWith(
                                      clearRegion: true,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
          // Meals list
          mealHistoryAsync.when(
            data: (historyState) {
              if (historyState.meals.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No meals found in this area',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == historyState.meals.length) {
                      return historyState.isLoadingMore
                          ? Skeletonizer(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: _buildMealCard(
                                  MealHistoryItem(
                                    id: '',
                                    mealName: 'Meal Name',
                                    cost: 0,
                                    currency: 'KES',
                                    upvotes: 0,
                                    downvotes: 0,
                                    eatenAt: DateTime.now(),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(height: 24);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildMealCard(historyState.meals[index]),
                    );
                  }, childCount: historyState.meals.length + 1),
                ),
              );
            },
            loading: () => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: Skeletonizer.sliver(
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildMealCard(
                        MealHistoryItem(
                          id: '',
                          mealName: 'Meal Name Placeholder',
                          cost: 0,
                          currency: 'KES',
                          upvotes: 0,
                          downvotes: 0,
                          eatenAt: DateTime.now(),
                        ),
                      ),
                    ),
                    childCount: 5,
                  ),
                ),
              ),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error loading meals: $error',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Share CTA
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Share what you ate',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Earn 50 pts per approved meal',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _showLogMealSheet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                      child: Text(
                        '+ Add',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(MealHistoryFilter filter) {
    return GestureDetector(
      onTap: _showFilterSheet,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: filter.isEmpty ? Colors.white : AppColors.accent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: filter.isEmpty
                ? Colors.black.withValues(alpha: 0.1)
                : AppColors.accent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune,
              size: 16,
              color: filter.isEmpty ? AppColors.textSecondary : Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              'Filter',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: filter.isEmpty ? AppColors.textSecondary : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveChip(String label, {required VoidCallback onRemove}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(MealHistoryItem meal) {
    final date = meal.eatenAt;
    final dateLabel = '${date.day}/${date.month}/${date.year}';
    final hasRecipe =
        meal.recipeInstructions != null && meal.recipeInstructions!.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  meal.mealName,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${meal.currency} ${meal.cost.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (meal.userName != null && meal.userName!.isNotEmpty) ...[
                Icon(
                  Icons.person_outline,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  meal.userName!,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                dateLabel,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          if (meal.notes != null && meal.notes!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              meal.notes!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () =>
                    ref.read(mealHistoryProvider.notifier).upvote(meal.id),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      size: 18,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${meal.upvotes}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: hasRecipe
                    ? () => showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (_) => _RecipeSheet(
                            mealName: meal.mealName,
                            recipeTitle: meal.recipeTitle,
                            recipeInstructions: meal.recipeInstructions,
                          ),
                        )
                    : null,
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 16,
                      color: hasRecipe
                          ? AppColors.accent
                          : AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'View Recipe',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: hasRecipe
                            ? AppColors.accent
                            : AppColors.textSecondary.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet();

  @override
  ConsumerState<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<_FilterSheet> {
  static const _countries = [
    'kenya',
    'uganda',
    'rwanda',
    'tanzania',
    'south sudan',
  ];
  static const _countryLabels = {
    'kenya': '🇰🇪 Kenya',
    'uganda': '🇺🇬 Uganda',
    'rwanda': '🇷🇼 Rwanda',
    'tanzania': '🇹🇿 Tanzania',
    'south sudan': '🇸🇸 South Sudan',
  };

  String? _selectedRegion;

  @override
  void initState() {
    super.initState();
    _selectedRegion = ref.read(mealHistoryFilterProvider).region;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollCtrl) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter meals',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _selectedRegion = null),
                  child: Text(
                    'Clear all',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Text(
              'COUNTRY',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _countries.map((country) {
                final isSelected = _selectedRegion == country;
                return GestureDetector(
                  onTap: () => setState(
                    () => _selectedRegion = isSelected ? null : country,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accent
                            : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      _countryLabels[country]!,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(mealHistoryFilterProvider.notifier).state =
                      MealHistoryFilter(region: _selectedRegion);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply filters',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeSheet extends StatelessWidget {
  final String mealName;
  final String? recipeTitle;
  final String? recipeInstructions;

  const _RecipeSheet({
    required this.mealName,
    this.recipeTitle,
    this.recipeInstructions,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, ctrl) => SingleChildScrollView(
        controller: ctrl,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Recipe for $mealName',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            if (recipeInstructions != null) ...[
              if (recipeTitle != null) ...[
                Text(
                  recipeTitle!,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  recipeInstructions!,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
            ] else
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    'No recipe shared for this meal',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LogMealSheet extends ConsumerStatefulWidget {
  const _LogMealSheet();

  @override
  ConsumerState<_LogMealSheet> createState() => _LogMealSheetState();
}

class _LogMealSheetState extends ConsumerState<_LogMealSheet> {
  final _formKey = GlobalKey<FormState>();
  final _mealNameCtrl = TextEditingController();
  final _costCtrl = TextEditingController();
  final _userCostCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _recipeTitleCtrl = TextEditingController();
  final _recipeInstructionsCtrl = TextEditingController();

  String _currency = 'KES';
  bool _isSubmitting = false;
  bool _addRecipe = false;

  static const _currencies = ['KES', 'UGX', 'RWF', 'TZS', 'SSP'];

  @override
  void dispose() {
    _mealNameCtrl.dispose();
    _costCtrl.dispose();
    _userCostCtrl.dispose();
    _notesCtrl.dispose();
    _recipeTitleCtrl.dispose();
    _recipeInstructionsCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSubmitting = true);

    try {
      final cost = double.parse(_costCtrl.text.trim());
      final userCostText = _userCostCtrl.text.trim();
      final userCost = userCostText.isNotEmpty
          ? double.tryParse(userCostText)
          : null;

      await ref
          .read(mealHistoryProvider.notifier)
          .logMeal(
            mealName: _mealNameCtrl.text.trim(),
            cost: cost,
            currency: _currency,
            userCost: userCost,
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
            recipeTitle: _addRecipe && _recipeTitleCtrl.text.trim().isNotEmpty
                ? _recipeTitleCtrl.text.trim()
                : null,
            recipeInstructions:
                _addRecipe && _recipeInstructionsCtrl.text.trim().isNotEmpty
                ? _recipeInstructionsCtrl.text.trim()
                : null,
          );

      if (mounted) {
        Navigator.of(context).pop();
        AppToast.show(context, 'Meal logged!', type: ToastType.success);
      }
    } catch (_) {
      if (mounted) {
        AppToast.show(
          context,
          'Failed to log meal. Please try again.',
          type: ToastType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(
      fontSize: 14,
      color: AppColors.textSecondary.withValues(alpha: 0.6),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.toastError),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.toastError),
    ),
  );

  Widget _label(String text) => Text(
    text,
    style: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Log a meal',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _label('Meal name *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mealNameCtrl,
                textCapitalization: TextCapitalization.sentences,
                decoration: _inputDecoration('e.g. Ugali na Sukuma'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Meal name is required'
                    : null,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Cost *'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _costCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: _inputDecoration('0'),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty)
                              return 'Required';
                            final n = double.tryParse(v.trim());
                            if (n == null || n < 0)
                              return 'Enter a valid amount';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Currency'),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _currency,
                          isExpanded: true,
                          decoration: _inputDecoration(''),
                          items: _currencies
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _currency = v ?? 'KES'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _label('What you actually paid (optional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _userCostCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _inputDecoration('Leave blank to use Cost above'),
              ),
              const SizedBox(height: 20),
              _label('Notes (optional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesCtrl,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: _inputDecoration('Any comments about this meal…'),
              ),
              const SizedBox(height: 20),
              // ── Recipe toggle ──────────────────────────────────────────
              GestureDetector(
                onTap: () => setState(() => _addRecipe = !_addRecipe),
                child: Row(
                  children: [
                    Icon(
                      _addRecipe
                          ? Icons.remove_circle_outline
                          : Icons.add_circle_outline,
                      size: 18,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _addRecipe ? 'Remove recipe' : 'Add a recipe (optional)',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              if (_addRecipe) ...[
                const SizedBox(height: 16),
                _label('Recipe title (optional)'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _recipeTitleCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _inputDecoration('e.g. Classic Ugali na Sukuma'),
                ),
                const SizedBox(height: 16),
                _label('Instructions *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _recipeInstructionsCtrl,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _inputDecoration(
                    'Step-by-step cooking instructions…',
                  ),
                  validator: (v) {
                    if (!_addRecipe) return null;
                    if (v == null || v.trim().isEmpty) {
                      return 'Instructions are required when adding a recipe';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Log meal',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
