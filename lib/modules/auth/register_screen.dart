import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/onboarding_provider.dart';
import '../../widgets/app_toast.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // "More" expandable controllers — pre-filled from onboarding draft
  final _nameController = TextEditingController();
  final _budgetController = TextEditingController();
  String? _selectedRegion;
  String? _selectedSubRegion;
  List<String> _dietaryGoals = [];

  bool _isLoading = false;
  bool _moreExpanded = false;

  static const _regionOptions = {
    'kenya': ['nairobi', 'mombasa', 'kisumu'],
  };

  static const _dietaryOptions = [
    'high-fibre',
    'high-protein',
    'low-carb',
    'vegetarian',
    'vegan',
    'halal',
    'diabetic-friendly',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _prefillFromDraft());
  }

  void _prefillFromDraft() {
    final draft = ref.read(onboardingProvider);
    _nameController.text = draft.name;
    _budgetController.text = draft.budget.toString();
    _selectedRegion = draft.region;
    _selectedSubRegion = draft.subRegion;
    _dietaryGoals = List<String>.from(draft.dietaryGoals);
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Persist any edits made in the "More" section back to the provider
    await ref.read(onboardingProvider.notifier).setName(_nameController.text.trim());
    await ref.read(onboardingProvider.notifier).setBudget(
          int.tryParse(_budgetController.text) ?? ref.read(onboardingProvider).budget,
        );
    if (_selectedRegion != null && _selectedSubRegion != null) {
      final currentDraft = ref.read(onboardingProvider);
      await ref.read(onboardingProvider.notifier).setLocation(
            county: currentDraft.county,
            region: _selectedRegion!,
            subRegion: _selectedSubRegion!,
          );
    }
    await ref.read(onboardingProvider.notifier).setDietaryGoals(_dietaryGoals);

    final draft = ref.read(onboardingProvider);
    final error = await ref.read(authProvider.notifier).register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: draft.name,
          dietaryGoals: draft.dietaryGoals,
          dailyBudget: draft.budget,
          region: draft.region,
          subRegion: draft.subRegion,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (error == null) {
      await ref.read(onboardingProvider.notifier).clear();
      if (!mounted) return;
      Navigator.of(context).pop();
    } else {
      AppToast.show(context, 'Registration failed. Please try again.', type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  "Create your\naccount",
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onboardingTextPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  draft.name.isNotEmpty
                      ? "Hey ${draft.name}, just a few more details"
                      : "Just a few more details",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.onboardingTextSecondary,
                  ),
                ),
                const SizedBox(height: 48),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'hello@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v!.contains('@') ? null : 'Enter a valid email',
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: '••••••••',
                  obscureText: true,
                  validator: (v) =>
                      v!.length >= 6 ? null : 'Password must be at least 6 characters',
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: '••••••••',
                  obscureText: true,
                  validator: (v) {
                    if (v!.isEmpty) return 'Please confirm your password';
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // ── More / onboarding details ──────────────────────────────
                _buildMoreSection(),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text(
                            'Register',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          // Header row
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _moreExpanded = !_moreExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Text(
                    'More',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onboardingTextSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '— review your onboarding details',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.onboardingTextSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _moreExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.onboardingTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: Colors.white12, height: 1),
                  const SizedBox(height: 20),

                  // Name
                  _buildTextField(
                    controller: _nameController,
                    label: 'Name',
                    hint: 'Your name',
                    validator: (v) => v!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 20),

                  // Daily budget
                  _buildTextField(
                    controller: _budgetController,
                    label: 'Daily Budget (KSh)',
                    hint: '200',
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n < 50) return 'Enter a valid budget (min KSh 50)';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Region
                  _buildLabel('Region'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    key: ValueKey(_selectedRegion),
                    initialValue: _selectedRegion,
                    dropdownColor: AppColors.brown,
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                    items: _regionOptions.keys
                        .map((r) => DropdownMenuItem(
                              value: r,
                              child: Text(r[0].toUpperCase() + r.substring(1)),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() {
                      _selectedRegion = v;
                      _selectedSubRegion = null;
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Sub-region
                  _buildLabel('Sub-region'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    key: ValueKey('${_selectedRegion}_$_selectedSubRegion'),
                    initialValue: _selectedSubRegion,
                    dropdownColor: AppColors.brown,
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                    items: (_regionOptions[_selectedRegion] ?? [])
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s[0].toUpperCase() + s.substring(1)),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedSubRegion = v),
                  ),
                  const SizedBox(height: 20),

                  // Dietary goals
                  _buildLabel('Dietary Goals'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _dietaryOptions.map((goal) {
                      final selected = _dietaryGoals.contains(goal);
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (selected) {
                            _dietaryGoals.remove(goal);
                          } else {
                            _dietaryGoals.add(goal);
                          }
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary.withValues(alpha: 0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            goal,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: selected ? AppColors.primary : AppColors.onboardingTextSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            crossFadeState: _moreExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.onboardingTextSecondary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.3)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorStyle: GoogleFonts.inter(color: AppColors.red),
          ),
        ),
      ],
    );
  }
}
