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
    final authRepo = ref.read(authRepoProvider) as AuthRepositoryImpl;
    // restoreSession() calls GoogleSignIn().signInSilently() internally —
    // no UI is shown, uses cached Google credentials to get a fresh Google
    // ID token, then POSTs it to /auth/google-mobile for backend tokens.
    await authRepo.restoreSession();
  } catch (e) {
    // Silent failure: network down or Google session expired.
    // The Dio interceptor's 401 handler will attempt recovery on the first
    // API call, or the user will be prompted to log in again.
    print('Session restore failed (will retry on first API call): $e');
  }
});