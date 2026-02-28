import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/data/repositories/auth_repo.dart';
import 'package:flatypus/core/di/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Runs once on app start.
/// If Firebase already has a persisted user, silently fetches a fresh
/// backend access_token so [tokenProvider] is populated before any API call.
///
/// States:
///   loading  → splash / blank screen
///   data     → session restored (or no user), proceed to AuthScreen routing
///   error    → session restore failed (network down etc.), proceed anyway
final sessionRestoreProvider = FutureProvider<void>((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return; // Not logged in, nothing to restore

  try {
    // Force-refresh ensures we get a valid token even after long offline periods
    final idToken = await user.getIdToken(true);
    if (idToken == null) return;

    final authRepo = ref.read(authRepoProvider) as AuthRepositoryImpl;
    await authRepo.restoreSession(idToken);
  } catch (e) {
    // Network might be down. The Dio interceptor's 401 handler will
    // re-exchange tokens lazily on the first API call.
    print('Session restore failed (will retry on first API call): $e');
  }
});