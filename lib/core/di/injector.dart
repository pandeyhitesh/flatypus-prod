import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flatypus/core/network/dio_client.dart';

// -- FEATURE AUTH
import 'package:flatypus/features/auth/data/repositories/auth_repo.dart';
import 'package:flatypus/features/auth/domain/repositories/auth_repository.dart';
import 'package:flatypus/features/auth/domain/usecases/logged_in_user_usecase.dart';
import 'package:flatypus/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flatypus/features/auth/domain/usecases/sign_in_with_google_usecase.dart';

// -- House Feature --
import 'package:flatypus/features/house/data/datasources/house_remote_ds.dart';
import 'package:flatypus/features/house/data/repositories/house_repo.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';
import 'package:flatypus/features/house/domain/usecases/create_house.dart';
import 'package:flatypus/features/house/domain/usecases/get_house.dart';



/// -- House --
// DATA SOURCES
final houseRemoteDSProvider = Provider<HouseRemoteDataSource>(
  (ref) => HouseRemoteDataSource(ref.read(dioProvider))
);
// REPOSITORY
final houseRepoProvider = Provider<HouseRepository>(
  (ref)=> HouseRepositoryImpl(ref.read(houseRemoteDSProvider)),
);
// USECASES
final createHouseUsecaseProvider = Provider(
  (ref) => CreateHouseUseCase(ref.read(houseRepoProvider)),
);
final getHouseUsecaseProvider = Provider(
  (ref) => GetHouseUseCase(ref.read(houseRepoProvider)),
);



/// -- Authentication --
// Data soureces
final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);
// Usecases
final googleSignInUsecaseProvider = Provider<SignInWithGoogleUseCase>(
  (ref) => SignInWithGoogleUseCase(ref.read(authRepoProvider)),
);
final logoutUsecaseProvider = Provider<LogoutUsecase>(
  (ref) => LogoutUsecase(ref.read(authRepoProvider)),
);
final loggedInUserUseCaseProvider = Provider<LoggedInUserUsecase>(
  (ref) => LoggedInUserUsecase(ref.read(authRepoProvider)),
);
