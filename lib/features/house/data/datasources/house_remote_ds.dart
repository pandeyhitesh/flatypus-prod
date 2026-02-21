import 'package:dio/dio.dart';
import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/data/model/house_model.dart';

class HouseRemoteDataSource {
  final Dio dio;
  HouseRemoteDataSource(this.dio);

  Future<HouseModel> createHouse(CreateHouseRequest request) async {
    final res = await dio.post('/house', data: request.toJson());
    return HouseModel.fromJson(res.data);
  }

  Future<HouseModel> getHouse(String id) async {
    final res = await dio.get('/houses/$id');
    return HouseModel.fromJson(res.data);
  }
}
