import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:flatypus/features/auth/domain/entities/auth_token.dart';
import 'package:flatypus/features/auth/domain/repositories/auth_repository.dart';
import 'package:flatypus/features/auth/presentation/providers/notifiers/token_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource service;
  Ref ref;
  AuthRepositoryImpl(this.service, this.ref);

  @override
  Future<UserCredential?> signInWithGoogle() async{
    try{
            // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Exchange Firebase ID token -> backend jwt
      final idToken = googleAuth?.idToken ?? '';
      await _exchangeAndStore(idToken);

      return userCredential;
    } catch (e) {
      print('Inside AuthRepository: $e');
    }
    return null;
  }

  /// Called by [sessionRestoreProvider] on app start when Firebase already
  /// has a persisted user. Silently re-exchanges for backend tokens.
  Future<void> restoreSession(String firebaseIdToken) async {
    await _exchangeAndStore(firebaseIdToken);
  }

  /// Called by the Dio interceptor on 401.
  /// Gets a fresh Firebase ID token and re-exchanges for new backend tokens.
  Future<AuthToken?> refreshTokens() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final freshIdToken = await user.getIdToken(true);
      if (freshIdToken == null) return null;

      return await _exchangeAndStore(freshIdToken);
    } catch (e) {
      print('refreshTokens error: $e');
      return null;
    }
  }

  /// Core helper: POST id_token -> backend, store returned access_token.
  Future<AuthToken> _exchangeAndStore(String idToken) async {
    final authToken = await service.googleMobileLogin(idToken);
    ref.read(tokenProvider.notifier).setTokens(authToken);
    return authToken;
  }

  @override
  Future<void> logOut() async{
    ref.read(tokenProvider.notifier).clear();
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  @override
  User? loggedInUser()=> FirebaseAuth.instance.currentUser;
  

  // @override
  // Future<Map<String, dynamic>> addUserIdInDb(String userId) async {
  //   return  service.addUserIdInDb(userId);
  // }
}