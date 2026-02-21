

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/domain/repositories/auth_repository.dart';

class LoggedInUserUsecase {
  final AuthRepository repo;
  LoggedInUserUsecase(this.repo);

  User? call() => repo.loggedInUser();
}