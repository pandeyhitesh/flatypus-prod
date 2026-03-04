import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flatypus/core/di/injector.dart';
import 'package:flatypus/features/auth/data/repositories/auth_repo.dart';
import 'package:flatypus/features/auth/presentation/providers/notifiers/token_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// A bare Dio instance used ONLY for auth endpoints (/auth/google-mobile etc.)
/// It has no auth interceptor to avoid the circular dependency
final authDioProvider = Provider<Dio>((ref){
  const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://flatipus-backend-production.up.railway.app/',
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {"Content-Type": "application/json"},
    ),
  );

  // Loging
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});


/// The main Dio instance used by all feature data sources.
/// Has the auth interceptor — safely reads authRepoProvider because
/// authRepoProvider now depends on authDioProvider, not this one.
final dioProvider = Provider<Dio>((ref) {
  const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://flatipus-backend-production.up.railway.app/',
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {"Content-Type": "application/json"},
    ),
  );

  // Loging
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  // Auth Interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Read the backend access_token from the in-memory token store
        final accessToken = ref.read(tokenProvider)?.accessToken;
        clog.error("In Dio Interceptor - Access Token: $accessToken");
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Handle token expiry: refresh and retry once
        if (error.response?.statusCode == 401) {
          try {
            // Re-exchange a fresh Firebase ID token for new backend tokens
            final authRepo = ref.read(authRepoProvider) as AuthRepositoryImpl;
            final newToken = await authRepo.refreshTokens();

            if (newToken != null) {
              // Retry the original request with the fresh access token
              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer ${newToken.accessToken}';
              final response = await dio.fetch(opts);
              return handler.resolve(response);
            }
          } catch (e) {
            print('Token refresh in interceptor failed: $e');
          }
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
});
