import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../core/app_colors.dart';
import '../../core/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _publicBase = 'http://10.0.2.2:3000';
  static const _budget = 300;
  static const _region = 'kenya';
  static const _mealTypes = ['breakfast', 'lunch', 'dinner'];

  final _authService = AuthService();

  // All 3 meal types loaded in parallel; keyed by mealType
  final Map<String, List<Map<String, dynamic>>> _allFoods = {};

  String _mealType = '';
  bool _isLoading = true;
  String? _error;
  bool _isAccepting = false;

  List<Map<String, dynamic>> get _currentFoods => _allFoods[_mealType] ?? [];

  @override
  void initState() {
    super.initState();
    _fetchAll();
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

  Future<List<Map<String, dynamic>>?> _fetchMealType(String mealType) async {
    final uri = Uri.parse(
      '$_publicBase/api/public/recommendations/foods/recommend'
      '?mealType=$mealType&budget=$_budget&region=$_region',
    );
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final recs = body['recommendations'] as Map<String, dynamic>;
      return (recs['foods'] as List).cast<Map<String, dynamic>>();
    }
    return null;
  }

  Future<void> _fetchAll() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final results = await Future.wait(_mealTypes.map(_fetchMealType));
      for (int i = 0; i < _mealTypes.length; i++) {
        if (results[i] != null) {
          _allFoods[_mealTypes[i]] = results[i]!;
        }
      }
      final current = _currentMealType();
      if (_allFoods.containsKey(current)) {
        setState(() {
          _mealType = current;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load recommendations';
          _isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        _error = 'Could not connect to server';
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _foodsPayload(List<Map<String, dynamic>> foods) {
    return foods
        .take(1)
        .map((f) => {
              'food_id': f['id'],
              'food_name': f['name'] as String,
              'cost': f['price_min_kes'],
            })
        .toList();
  }

  Future<void> _acceptCurrentMeal() async {
    if (_currentFoods.isEmpty || _isAccepting) return;
    setState(() => _isAccepting = true);
    try {
      final res = await _authService.protectedRequest(
        'POST',
        '/recommendations/accept',
        body: jsonEncode({
          'mealType': _mealType,
          'foods': _foodsPayload(_currentFoods),
        }),
      );
      if (!mounted) return;
      if (res.statusCode == 200 || res.statusCode == 201) {
        _showSnackBar('$_mealType accepted!', success: true);
      } else {
        _showSnackBar('Could not accept meal. Please try again.');
      }
    } catch (_) {
      if (mounted) _showSnackBar('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isAccepting = false);
    }
  }

  Future<void> _acceptDayPlan() async {
    if (_isAccepting) return;
    setState(() => _isAccepting = true);
    try {
      final plan = <String, dynamic>{};
      for (final type in _mealTypes) {
        final foods = _allFoods[type] ?? [];
        if (foods.isNotEmpty) {
          plan[type] = _foodsPayload(foods);
        }
      }
      final res = await _authService.protectedRequest(
        'POST',
        '/recommendations/accept/plan',
        body: jsonEncode({'plan': plan}),
      );
      if (!mounted) return;
      if (res.statusCode == 200 || res.statusCode == 201) {
        _showSnackBar("Today's plan accepted!", success: true);
      } else {
        _showSnackBar('Could not accept plan. Please try again.');
      }
    } catch (_) {
      if (mounted) _showSnackBar('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isAccepting = false);
    }
  }

  void _showSnackBar(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.accent : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 8),
              Text(
                'Habari, Kamau',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'KSh $_budget',
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
              // Featured Meal Card
              _isLoading
                  ? _buildFeaturedCardSkeleton()
                  : _error != null
                      ? _buildErrorCard()
                      : _buildFeaturedCard(),
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
                child: _isLoading
                    ? _buildSmallCardSkeletons()
                    : _error != null || _currentFoods.length < 2
                        ? const SizedBox.shrink()
                        : ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int i = 1; i < _currentFoods.length; i++) ...[
                                _buildSmallMealCard(
                                  _currentFoods[i]['name'] as String,
                                  'KSh ${_currentFoods[i]['price_min_kes']}',
                                  i == 1 ? AppColors.accent : AppColors.protein,
                                ),
                                if (i < _currentFoods.length - 1) const SizedBox(width: 12),
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
                        onPressed: _isAccepting ? null : _acceptDayPlan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: _isAccepting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Accept today's plan",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/suggestion');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                          foregroundColor: AppColors.textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Swap',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard() {
    final food = _currentFoods.first;
    final name = food['name'] as String;
    final priceMin = food['price_min_kes'];
    final commonAt = (food['common_at'] as List?)?.cast<String>() ?? [];
    final location = commonAt.isNotEmpty ? commonAt.first : _region;

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
                  'KSh $priceMin',
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
            name,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$location · ${_region[0].toUpperCase()}${_region.substring(1)}',
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
                onTap: _isAccepting ? null : _acceptCurrentMeal,
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
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildErrorCard() {
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
          _error ?? 'Something went wrong',
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
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
