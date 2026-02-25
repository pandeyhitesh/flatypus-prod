import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref){
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
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  // Loging
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  // Auth Interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // final token = ref.read(authtokenProvider);
      // options.headers["Authorization"] = "Bearer $token";
      return handler.next(options);
    },
    onError: (error, handler) {
      return handler.next(error);
    },
  ));


  return dio;
});