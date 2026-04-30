import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api_client.dart';
import '../models/notification_settings.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.read(apiClientProvider));
});

class NotificationRepository {
  final ApiClient _client;

  NotificationRepository(this._client);

  /// GET /users/notifications — returns the full settings object.
  Future<NotificationSettings> getSettings() async {
    final data = await _client.get('/users/notifications/');
    final notifJson = data['notifications'] as Map<String, dynamic>? ?? {};
    return NotificationSettings.fromJson(notifJson);
  }

  /// PUT /users/notifications — sends only the changed category/channels.
  /// Returns the merged settings from the server.
  Future<NotificationSettings> updateSettings({
    required String category,
    required NotificationChannels channels,
  }) async {
    final data = await _client.put(
      '/users/notifications/',
      body: {
        'notifications': {
          category: channels.toJson(),
        },
      },
    );
    final notifJson = data['notifications'] as Map<String, dynamic>? ?? {};
    return NotificationSettings.fromJson(notifJson);
  }
}
