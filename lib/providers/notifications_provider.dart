import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/notification_settings.dart';
import '../data/repositories/notification_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

sealed class NotificationsState {
  const NotificationsState();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  final NotificationSettings settings;
  const NotificationsLoaded(this.settings);
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final notificationsProvider =
    NotifierProvider<NotificationsNotifier, NotificationsState>(
  NotificationsNotifier.new,
);

class NotificationsNotifier extends Notifier<NotificationsState> {
  @override
  NotificationsState build() {
    load();
    return const NotificationsLoading();
  }

  NotificationRepository get _repo => ref.read(notificationRepositoryProvider);

  Future<void> load() async {
    state = const NotificationsLoading();
    try {
      final settings = await _repo.getSettings();
      state = NotificationsLoaded(settings);
    } catch (e) {
      state = NotificationsError(e.toString());
    }
  }

  /// Optimistically updates a single channel toggle, then persists to the API.
  /// On error, reverts to previous state and rethrows so the UI can show a snackbar.
  Future<void> toggleChannel({
    required String category,
    required String channel,
    required bool value,
  }) async {
    final previous = state;

    // --- optimistic update ---
    if (previous is NotificationsLoaded) {
      final old = previous.settings.forCategory(category);
      final updated = switch (channel) {
        'email' => old.copyWith(email: value),
        'push' => old.copyWith(push: value),
        'whatsapp' => old.copyWith(whatsapp: value),
        _ => old,
      };
      state = NotificationsLoaded(
        previous.settings.copyWithCategory(category, updated),
      );
    }

    try {
      final current = (state as NotificationsLoaded).settings;
      final merged = await _repo.updateSettings(
        category: category,
        channels: current.forCategory(category),
      );
      state = NotificationsLoaded(merged);
    } catch (e) {
      // revert
      state = previous;
      rethrow;
    }
  }
}
