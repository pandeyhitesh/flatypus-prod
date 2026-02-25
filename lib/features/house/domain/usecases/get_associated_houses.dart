import 'package:flatypus/features/house/data/dto/house_response_dto.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class GetAssociatedHousesUseCase {
  final HouseRepository repo;
  GetAssociatedHousesUseCase(this.repo);

  Future<AssociatedHousesResponse> call() => repo.getAssociatedHouses();
}