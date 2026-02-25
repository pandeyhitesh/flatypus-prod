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
  Future<House> getHouse(String houseId) => service.getHouse(houseId);

  @override
  Future<House> joinHouse(String houseKey) => service.joinHouse(houseKey);

  @override
  Future<AssociatedHousesResponse> getAssociatedHouses() =>
      service.getAssociatedHouses();

  @override
  Future<void> deleteHouse(String houseId) => service.deleteHouse(houseId);

  @override
  Future<House> updateMemberRole(UpdateMemberRoleRequest request) =>
      service.updateMemberRole(request);
}