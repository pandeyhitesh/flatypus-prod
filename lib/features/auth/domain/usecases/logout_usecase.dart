
import 'package:flatypus/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase{
  final AuthRepository repo;
  LogoutUsecase(this.repo);

  Future<void> call() => repo.logOut();
}