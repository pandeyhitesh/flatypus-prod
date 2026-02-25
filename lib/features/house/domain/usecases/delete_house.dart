import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class DeleteHouseUseCase {
  final HouseRepository repo;
  DeleteHouseUseCase(this.repo);

  Future<void> call(String houseId) => repo.deleteHouse(houseId);
}