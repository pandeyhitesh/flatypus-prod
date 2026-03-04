import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/usecases/create_house.dart';
import 'package:flatypus/features/house/domain/usecases/get_house.dart';
import 'package:flatypus/features/house/domain/usecases/join_house.dart';
import 'package:flatypus/features/house/domain/usecases/delete_house.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseNotifier extends StateNotifier<AsyncValue<House?>> {
  final CreateHouseUseCase _createUseCase;
  final JoinHouseUseCase _joinUseCase;
  final DeleteHouseUseCase _deleteUseCase;
  final GetHouseUseCase _getHouseUseCase;
  HouseNotifier(
    this._createUseCase,
    this._joinUseCase,
    this._deleteUseCase,
    this._getHouseUseCase,
  ) : super(const AsyncData(null));

  Future<void> create(CreateHouseRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _createUseCase(request));
  }

  Future<void> join(String houseKey) async {
    state = const AsyncLoading();
    final joined = await AsyncValue.guard(() => _joinUseCase(houseKey));
    // fetch full detail using the returned id
    state = await joined.when(
      data: (house) async {
        if (house.id == null) return joined;
        return AsyncValue.guard(() => _getHouseUseCase(house.id!));
      },
      error: (error, stackTrace) => AsyncError(error, stackTrace),
      loading: () => const AsyncLoading(),
    );
  }

  Future<void> delete(String houseId) async {
    state = const AsyncLoading();
    await AsyncValue.guard(() => _deleteUseCase(houseId));
    state = const AsyncData(null); // active house is gone
  }
}
