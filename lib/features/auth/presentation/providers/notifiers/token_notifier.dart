

import 'package:flatypus/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenNotifier extends StateNotifier<AuthToken?>{
  TokenNotifier() : super(null);

  void setTokens(AuthToken token) => state = token;

  void clear() => state = null;

  String? get accessToken => state?.accessToken;
  String? get refreshToken => state?.refreshToken;
}

final tokenProvider = StateNotifierProvider<TokenNotifier, AuthToken?>(
  (ref) => TokenNotifier()
);