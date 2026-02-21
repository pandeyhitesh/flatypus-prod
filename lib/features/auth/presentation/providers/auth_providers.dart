import 'package:firebase_auth/firebase_auth.dart';
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
