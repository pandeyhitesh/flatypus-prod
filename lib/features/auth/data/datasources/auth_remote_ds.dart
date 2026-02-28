

import 'package:dio/dio.dart';
import 'package:flatypus/core/network/api_routes.dart';

class AuthRemoteDataSource{
  final Dio dio;
  AuthRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> addUserIdInDb(String userId) async {
    final res = await dio.post(ApiRoutes.auth.googleMobile, data: {'id_token': userId});
    return res.data;
  }
}