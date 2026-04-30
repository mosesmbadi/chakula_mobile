import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../data/models/notification_settings.dart';
import '../../providers/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: switch (state) {
        NotificationsLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        NotificationsError(:final message) => _ErrorView(
            message: message,
            onRetry: () => ref.read(notificationsProvider.notifier).load(),
          ),
        NotificationsLoaded(:final settings) => _SettingsBody(settings: settings),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Body
// ---------------------------------------------------------------------------

class _SettingsBody extends StatelessWidget {
  final NotificationSettings settings;

  const _SettingsBody({required this.settings});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        Text(
          'Manage how you receive updates from Chakula across different channels.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        _CategoryCard(
          category: 'marketing',
          label: 'Marketing',
          description: 'Promotions, tips, and food recommendations',
          icon: Icons.campaign_outlined,
          channels: settings.marketing,
        ),
        const SizedBox(height: 16),
        _CategoryCard(
          category: 'security',
          label: 'Security',
          description: 'Login alerts and account safety notifications',
          icon: Icons.shield_outlined,
          channels: settings.security,
        ),
        const SizedBox(height: 16),
        _CategoryCard(
          category: 'social',
          label: 'Social',
          description: 'Community updates, likes, and comments',
          icon: Icons.people_outline_rounded,
          channels: settings.social,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Category card
// ---------------------------------------------------------------------------

class _CategoryCard extends ConsumerWidget {
  final String category;
  final String label;
  final String description;
  final IconData icon;
  final NotificationChannels channels;

  const _CategoryCard({
    required this.category,
    required this.label,
    required this.description,
    required this.icon,
    required this.channels,
  });

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref,
    String channel,
    bool value,
  ) async {
    try {
      await ref.read(notificationsProvider.notifier).toggleChannel(
            category: category,
            channel: channel,
            value: value,
          );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to save. Please try again.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.toastError,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            thickness: 1,
            color: Colors.black.withValues(alpha: 0.05),
            indent: 20,
            endIndent: 20,
          ),

          // ── Channel toggles ───────────────────────────────────────────────
          _ChannelRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: channels.email,
            onChanged: (v) => _toggle(context, ref, 'email', v),
          ),
          _ChannelRow(
            icon: Icons.notifications_outlined,
            label: 'Push',
            value: channels.push,
            onChanged: (v) => _toggle(context, ref, 'push', v),
          ),
          _ChannelRow(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'WhatsApp',
            value: channels.whatsapp,
            onChanged: (v) => _toggle(context, ref, 'whatsapp', v),
            isLast: true,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Channel row (single toggle)
// ---------------------------------------------------------------------------

class _ChannelRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLast;

  const _ChannelRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 12, isLast ? 8 : 0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error view
// ---------------------------------------------------------------------------

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.toastError.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 40,
                color: AppColors.toastError,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Could not load notifications',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text('Try Again', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
