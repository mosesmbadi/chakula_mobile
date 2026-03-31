import 'package:flutter/material.dart';
import 'user_model.dart';
import 'auth_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  final AuthService _authService = AuthService();

  String _draftName = '';
  int _draftBudget = 200;
  List<String> _draftDietaryGoals = ['high-fibre'];

  UserProvider() {
    _init();
  }

  Future<void> _init() async {
    _user = await _authService.getStoredUser();
    _isLoading = false;
    notifyListeners();
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  String get draftName => _draftName;
  int get draftBudget => _draftBudget;
  List<String> get draftDietaryGoals => _draftDietaryGoals;

  void setDraftName(String name) {
    _draftName = name;
    notifyListeners();
  }

  void setDraftBudget(int budget) {
    _draftBudget = budget;
    notifyListeners();
  }

  void setDraftDietaryGoals(List<String> goals) {
    _draftDietaryGoals = goals;
    notifyListeners();
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required List<String> dietaryGoals,
    required int dailyBudget,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.register(
        email: email,
        password: password,
        name: name,
        dietaryGoals: dietaryGoals,
        dailyBudget: dailyBudget,
      );
      if (user != null) {
        _user = user;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Registration error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _authService.clearStorage();
    _user = null;
    notifyListeners();
  }
}
