
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase{
  final AuthRepository repo;
  SignInWithGoogleUseCase(this.repo);

  Future<UserCredential?> call() => repo.signInWithGoogle();
}