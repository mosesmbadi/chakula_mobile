import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app_config.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

class ApiClient {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _timeout = Duration(seconds: 15);

  final _storage = const FlutterSecureStorage();

  Map<String, String> _baseHeaders({String? token}) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParams,
    bool authenticated = true,
  }) async {
    final token = authenticated ? await _storage.read(key: _accessTokenKey) : null;
    final uri = Uri.parse('${AppConfig.apiBaseUrl}$path')
        .replace(queryParameters: queryParams);

    debugPrint('[ApiClient] GET: $uri');
    
    final response = await http
        .get(uri, headers: _baseHeaders(token: token))
        .timeout(_timeout);

    if (response.statusCode == 401 && authenticated) {
      return _refreshAndRetry(() => get(path, queryParams: queryParams));
    }

    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    required Map<String, dynamic> body,
    bool authenticated = true,
  }) async {
    final token = authenticated ? await _storage.read(key: _accessTokenKey) : null;
    final uri = Uri.parse('${AppConfig.apiBaseUrl}$path');

    final response = await http
        .post(uri, headers: _baseHeaders(token: token), body: jsonEncode(body))
        .timeout(_timeout);

    if (response.statusCode == 401 && authenticated) {
      return _refreshAndRetry(() => post(path, body: body));
    }

    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> _refreshAndRetry(
    Future<Map<String, dynamic>> Function() retry,
  ) async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null) throw ApiException(401, 'Session expired. Please log in again.');

    final refreshUri = Uri.parse('${AppConfig.apiBaseUrl}/users/refresh/');
    final refreshResponse = await http.post(
      refreshUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    ).timeout(_timeout);

    if (refreshResponse.statusCode != 200) {
      throw ApiException(401, 'Session expired. Please log in again.');
    }

    final data = jsonDecode(refreshResponse.body);
    await _storage.write(key: _accessTokenKey, value: data['accessToken'] as String);
    await _storage.write(key: _refreshTokenKey, value: data['refreshToken'] as String);

    return retry();
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    debugPrint('[ApiClient] Error ${response.statusCode}: ${response.body}');
    throw ApiException(response.statusCode, _extractMessage(response.body));
  }

  String _extractMessage(String body) {
    try {
      final data = jsonDecode(body);
      return data['message'] as String? ?? 'Something went wrong';
    } catch (_) {
      return 'Something went wrong';
    }
  }

  Future<void> saveTokens(String access, String refresh) async {
    await _storage.write(key: _accessTokenKey, value: access);
    await _storage.write(key: _refreshTokenKey, value: refresh);
  }

  Future<void> clearTokens() async {
    await _storage.deleteAll();
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  const ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
