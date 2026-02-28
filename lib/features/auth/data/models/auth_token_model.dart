import 'package:flatypus/features/auth/domain/entities/auth_token.dart';

/// Holds the backend JWT tokens returned by /auth/google-mobile
class AuthTokenModel extends AuthToken {

  const AuthTokenModel({
    required super.accessToken,
    super.refreshToken,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) => 
      AuthTokenModel(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String?,
      );

  @override
  String toString() => 'AuthToken(accessToken: [redacted])';
}