import 'package:flatypus/features/house/data/datasources/house_remote_ds.dart';
import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/data/dto/house_response_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final HouseRemoteDataSource service;
  HouseRepositoryImpl(this.service);

  @override
  Future<House> createHouse(CreateHouseRequest request) =>
      service.createHouse(request);

  @override
  Future<House> getHouse(String id) => service.getHouse(id);

  @override
  Future<void> deleteHouse(String houseId) {
    // TODO: implement deleteHouse
    throw UnimplementedError();
  }

  @override
  Future<AssociatedHousesResponse> getAssociatedHouses() {
    // TODO: implement getAssociatedHouses
    throw UnimplementedError();
  }

  @override
  Future<House> joinHouse(String houseId) {
    // TODO: implement joinHouse
    throw UnimplementedError();
  }

  @override
  Future<House> updateMemberRole(UpdateMemberRoleRequest request) {
    // TODO: implement updateMemberRole
    throw UnimplementedError();
  }
}
