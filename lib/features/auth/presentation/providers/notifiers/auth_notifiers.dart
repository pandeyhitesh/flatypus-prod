import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AsyncValue<UserCredential?>> {
  final SignInWithGoogleUseCase _useCase;
  AuthNotifier(this._useCase) : super(const AsyncData(null));
  
  Future<UserCredential?> googleLogin() async {
    state = const AsyncLoading();

    // perform the sign in and update state with the result
    state = await AsyncValue.guard<UserCredential?>(() => _useCase());

    // if you need to persist the userId later you can call another use case here
    // await _addUserIdInDbUseCase(userId);
    return state.value;
  }
}