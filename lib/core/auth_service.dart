import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'user_model.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  static const String apiKey = '8ZVMFiRHEuTUuCkZKabNtb6KGPpNpE983Xw2-SToVxw';
  
  final _storage = const FlutterSecureStorage();

  // Storage Keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';

  Future<void> _saveTokens(String access, String refresh) async {
    await _storage.write(key: _accessTokenKey, value: access);
    await _storage.write(key: _refreshTokenKey, value: refresh);
  }

  Future<void> _saveUserData(User user) async {
    final userData = {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'dietaryGoals': user.dietaryGoals,
      'dailyBudget': user.dailyBudget,
    };
    await _storage.write(key: _userDataKey, value: jsonEncode(userData));
  }

  Future<User?> getStoredUser() async {
    final access = await _storage.read(key: _accessTokenKey);
    final refresh = await _storage.read(key: _refreshTokenKey);
    final userDataJson = await _storage.read(key: _userDataKey);

    if (access != null && refresh != null && userDataJson != null) {
      final data = jsonDecode(userDataJson);
      return User.fromJson({
        ...data,
        'accessToken': access,
        'refreshToken': refresh,
      });
    }
    return null;
  }

  Future<void> clearStorage() async {
    await _storage.deleteAll();
  }

  Future<User?> register({
    required String email,
    required String password,
    required String name,
    required List<String> dietaryGoals,
    required int dailyBudget,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register/'),
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'dietaryGoals': dietaryGoals,
        'dailyBudget': dailyBudget,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userJson = data['user'] ?? data;
      final user = User.fromJson(userJson);

      if (user.accessToken != null && user.refreshToken != null) {
        await _saveTokens(user.accessToken!, user.refreshToken!);
        await _saveUserData(user);
      }
      return user;
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<Map<String, String>?> refreshTokens(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/refresh/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final access = data['accessToken'] as String;
        final refresh = data['refreshToken'] as String;
        await _saveTokens(access, refresh);
        return {'accessToken': access, 'refreshToken': refresh};
      }
    } catch (e) {
      debugPrint('Token refresh error: $e');
    }
    return null;
  }

  // Wrapper for authenticated requests
  Future<http.Response> protectedRequest(
    String method,
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    String? token = await _storage.read(key: _accessTokenKey);
    
    final combinedHeaders = {
      'Content-Type': 'application/json',
      'x-api-key': apiKey,
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    };

    final url = Uri.parse('$baseUrl$path');
    http.Response response;

    // Initial request
    switch (method.toUpperCase()) {
      case 'GET': response = await http.get(url, headers: combinedHeaders); break;
      case 'POST': response = await http.post(url, headers: combinedHeaders, body: body); break;
      case 'PUT': response = await http.put(url, headers: combinedHeaders, body: body); break;
      case 'DELETE': response = await http.delete(url, headers: combinedHeaders, body: body); break;
      default: throw Exception('Unsupported HTTP method: $method');
    }

    // Handle 401 Unauthorized -> Refresh Token
    if (response.statusCode == 401) {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken != null) {
        final newTokens = await refreshTokens(refreshToken);
        if (newTokens != null) {
          // Retry original request with new token
          combinedHeaders['Authorization'] = 'Bearer ${newTokens['accessToken']}';
          switch (method.toUpperCase()) {
            case 'GET': return await http.get(url, headers: combinedHeaders);
            case 'POST': return await http.post(url, headers: combinedHeaders, body: body);
            case 'PUT': return await http.put(url, headers: combinedHeaders, body: body);
            case 'DELETE': return await http.delete(url, headers: combinedHeaders, body: body);
          }
        }
      }
    }

    return response;
  }
}
