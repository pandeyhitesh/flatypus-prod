import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/data/dto/house_response_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';

abstract class HouseRepository {
  Future<House> createHouse(CreateHouseRequest request);
  Future<House> getHouse(String houseId);
  Future<House> joinHouse(String houseId);
  Future<AssociatedHousesResponse> getAssociatedHouses();
  Future<void> deleteHouse(String houseId);
  Future<House> updateMemberRole(UpdateMemberRoleRequest request);
}
