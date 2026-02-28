import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async{
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // Always fetch a fresh token; Firebase caches and auto-refreshes it
            // final token = // TODO: access token of the user
            final token = await user.getIdToken();
            // options.headers["Authorization"] = "Bearer $token";
            print("Added auth token to request: $token");
          }

        } catch (e) {
          print("Error fetching token: $e");
          // If token fetch fails, let the request proceed unauthenticated.
          // The server will respond with 401 which is caught in onError below.
        }
        return handler.next(options);
      },
      onError: (error, handler) async{
        // Handle token expiry: refresh and retry once
        if (error.response?.statusCode == 401) {
          try {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // Force-refresh the token
              final freshToken = await user.getIdToken(true);
              final opts = error.requestOptions;
              opts.headers["Authorization"] = "Bearer $freshToken";

              // Retry the original request with the new token
              final response = await dio.fetch(opts);
              return handler.resolve(response);
            }
          } catch (e) {
            // Refresh failed — propagate the original error
          }
        }
        return handler.next(error);
      },
    ),
  );


  return dio;
});