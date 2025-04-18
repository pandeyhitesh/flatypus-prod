import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/services/auth_service.dart';
import 'package:flatypus/services/cloud_messaging/firebase_notification_service.dart';
import 'package:flatypus/state/controllers/loading_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { loggedIn, loggedOut }

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthService _authService;

  Ref _ref;
  AuthNotifier(this._ref, this._authService) : super(AuthStatus.loggedOut) {
    _checkAuthStatus();
    // Run authStateChanges listener in a separate task
    Future.microtask(() {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        print("## Auth state changed = $user");
        final newState =
            user != null ? AuthStatus.loggedIn : AuthStatus.loggedOut;
        if (newState != state) {
          state = newState;
        }
      });
    });
  }

  Future<void> _checkAuthStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final newState = user != null ? AuthStatus.loggedIn : AuthStatus.loggedOut;

    if (newState != state) {
      // Only update if state actually changes
      state = newState;
    }
  }

  Future<void> login() async {
    _ref.read(loadingControllerProvider.notifier).state = true;
    final userCred = await _authService.signInWithGoogle();
    // await FirebaseNotificationService().updateUserFCMToken(userCred.user?.uid);
    _ref.read(loadingControllerProvider.notifier).state = false;
    // state = AuthStatus.loggedIn;
  }

  Future<void> logout() async {
    _ref.read(loadingControllerProvider.notifier).state = true;
    await _authService.logOut();
    _ref.read(loadingControllerProvider.notifier).state = false;
    // state = AuthStatus.loggedOut;
  }
}
