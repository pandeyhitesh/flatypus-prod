import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class CreateHouseUseCase {
  final HouseRepository repo;
  CreateHouseUseCase(this.repo);

  Future<House> call(CreateHouseRequest request) => repo.createHouse(request);
}
