import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class JoinHouseUseCase {
  final HouseRepository repo;
  JoinHouseUseCase(this.repo);

  Future<House> call(String houseKey) => repo.joinHouse(houseKey);
}