import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/presentation/providers/notifiers/auth_notifiers.dart';
import 'package:flatypus/core/di/injector.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInWithGoogleProvider = FutureProvider<UserCredential?>(
  (ref) => ref.read(googleSignInUsecaseProvider)(),
);

final logoutProvider = FutureProvider<void>(
  (ref) => ref.read(logoutUsecaseProvider)(),
);

final loggedInUser = FutureProvider<User?>(
  (ref) => ref.read(loggedInUserUseCaseProvider)(),
);

final authProvider = FutureProvider<AuthStatus>((ref) async {
  final user = await ref.watch(loggedInUser.future);
  return user != null ? AuthStatus.loggedIn : AuthStatus.loggedOut;
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserCredential?>>(
  (ref) => AuthNotifier(ref.read(googleSignInUsecaseProvider)),
    // final notifier = AuthNotifier(ref.read(googleSignInUsecaseProvider));
    // // kick off the google login
    // notifier.googleLogin();
    // return notifier;
  // },
);