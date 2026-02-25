import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/repositories/house_repository.dart';

class UpdateMemberRoleUseCase {
  final HouseRepository repo;
  UpdateMemberRoleUseCase(this.repo);

  Future<House> call(UpdateMemberRoleRequest request) =>
      repo.updateMemberRole(request);
}