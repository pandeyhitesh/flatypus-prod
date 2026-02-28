

import 'package:dio/dio.dart';
import 'package:flatypus/core/network/api_routes.dart';
import 'package:flatypus/features/auth/data/models/auth_token_model.dart';
import 'package:flatypus/features/auth/domain/entities/auth_token.dart';

class AuthRemoteDataSource{
  final Dio dio;
  AuthRemoteDataSource(this.dio);

  Future<AuthToken> googleMobileLogin(String idToken) async {
    final res = await dio.post(
      ApiRoutes.auth.googleMobile, 
      data: {'id_token': idToken},
    );
    return AuthTokenModel.fromJson(res.data as Map<String, dynamic>);
  }

  /// Re-authenticates with a fresh Firebase ID token (used on 401 recovery).
  /// This is the same as [googleMobileLogin] but named explicitly for clarity.
  Future<AuthToken> refreshSession(String freshIdToken) =>
      googleMobileLogin(freshIdToken);
}