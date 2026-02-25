import 'package:dio/dio.dart';
import 'package:flatypus/core/network/api_routes.dart';
import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/data/dto/house_response_dto.dart';
import 'package:flatypus/features/house/data/model/house_model.dart';

class HouseRemoteDataSource {
  final Dio dio;
  HouseRemoteDataSource(this.dio);

  Future<HouseModel> createHouse(CreateHouseRequest request) async {
    final res = await dio.post(ApiRoutes.house.create, data: request.toJson());
    return HouseModel.fromJson(res.data);
  }

  Future<HouseModel> getHouse(String id) async {
    final res = await dio.get(ApiRoutes.house.getById(id));
    return HouseModel.fromJson(res.data);
  }

  Future<HouseModel> joinHouse(String houseKey) async {
    final res = await dio.post(ApiRoutes.house.join, data: {'house_key': houseKey});
    return HouseModel.fromJson(res.data);
  }

  Future<AssociatedHousesResponse> getAssociatedHouses({
    int limit = 10,
    int offset = 0,
  }) async {
    final res = await dio.get(
      ApiRoutes.house.mine,
      queryParameters: {'limit': limit, 'offset': offset},
    );
    return AssociatedHousesResponse.fromJson(res.data);
  }

  Future<void> deleteHouse(String houseId) async {
    await dio.delete(ApiRoutes.house.delete(houseId));
  }

  Future<HouseModel> updateMemberRole(UpdateMemberRoleRequest request) async {
    final res = await dio.put(
      ApiRoutes.house.updateMemberRole(request.houseId, request.userId),
      data: request.toJson(),
    );
    return HouseModel.fromJson(res.data);
  }
}