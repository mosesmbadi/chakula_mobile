import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user.dart';
import '../data/repositories/auth_repository.dart';

// ---------------------------------------------------------------------------
// Auth state
// ---------------------------------------------------------------------------

sealed class AuthState {
  const AuthState();
}

class AuthInitializing extends AuthState {
  const AuthInitializing();
}

class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

// ---------------------------------------------------------------------------
// Auth notifier
// ---------------------------------------------------------------------------

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _init();
    return const AuthInitializing();
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _init() async {
    final user = await _repo.getStoredUser();
    state = user != null ? AuthAuthenticated(user) : const AuthUnauthenticated();
  }

  Future<String?> register({
    required String email,
    required String password,
    required String name,
    required List<String> dietaryGoals,
    required int dailyBudget,
    required String region,
    required String subRegion,
  }) async {
    state = const AuthInitializing();
    try {
      final user = await _repo.register(
        email: email,
        password: password,
        name: name,
        dietaryGoals: dietaryGoals,
        dailyBudget: dailyBudget,
        region: region,
        subRegion: subRegion,
      );
      state = AuthAuthenticated(user);
      return null; // no error
    } catch (e) {
      state = const AuthUnauthenticated();
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _repo.clearSession();
    state = const AuthUnauthenticated();
  }
}
