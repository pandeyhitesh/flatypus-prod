import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/usecases/update_member_role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateMemberRoleNotifier extends StateNotifier<AsyncValue<House?>> {
  final UpdateMemberRoleUseCase usecase;
  UpdateMemberRoleNotifier(this.usecase) : super(const AsyncData(null));

  Future<void> update(UpdateMemberRoleRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => usecase(request));
  }
}