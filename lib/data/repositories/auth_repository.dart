import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/api_client.dart';
import '../models/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(apiClientProvider));
});

class AuthRepository {
  static const _userDataKey = 'user_data';

  final ApiClient _client;
  final _storage = const FlutterSecureStorage();

  AuthRepository(this._client);

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required List<String> dietaryGoals,
    required int dailyBudget,
    required String region,
    required String subRegion,
  }) async {
    final data = await _client.post(
      '/users/register/',
      body: {
        'email': email,
        'password': password,
        'name': name,
        'dietaryGoals': dietaryGoals,
        'dailyBudget': dailyBudget,
        'region': region,
        'sub_region': subRegion,
      },
      authenticated: false,
    );

    final userJson = data['user'] as Map<String, dynamic>? ?? data;
    final user = User.fromJson(userJson);

    final accessToken = data['accessToken'] as String? ??
        userJson['accessToken'] as String?;
    final refreshToken = data['refreshToken'] as String? ??
        userJson['refreshToken'] as String?;

    if (accessToken != null && refreshToken != null) {
      await _client.saveTokens(accessToken, refreshToken);
    }

    await _saveUserData(user);
    return user;
  }

  Future<User?> getStoredUser() async {
    final access = await _client.getAccessToken();
    final userDataJson = await _storage.read(key: _userDataKey);

    if (access != null && userDataJson != null) {
      final data = jsonDecode(userDataJson) as Map<String, dynamic>;
      return User.fromJson(data);
    }
    return null;
  }

  Future<void> clearSession() async {
    await _client.clearTokens();
    await _storage.delete(key: _userDataKey);
  }

  Future<void> _saveUserData(User user) async {
    await _storage.write(key: _userDataKey, value: jsonEncode(user.toJson()));
  }
}
