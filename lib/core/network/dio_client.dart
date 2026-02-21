import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref){
  final dio = Dio(
    BaseOptions(
      baseUrl: "",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
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