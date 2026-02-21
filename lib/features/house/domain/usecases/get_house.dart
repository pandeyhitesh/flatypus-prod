import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class GetHouseUseCase {
  final HouseRepository repo;
  GetHouseUseCase(this.repo);

  Future<House> call(String houseId) => repo.getHouse(houseId);
}
