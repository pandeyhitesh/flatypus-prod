import 'package:flatypus/services/auth_service.dart';
import 'package:flatypus/state/notifires/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => const AuthService());
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthNotifier(ref, authService);
});
