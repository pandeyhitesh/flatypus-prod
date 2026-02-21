import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/domain/usecases/create_house.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateHouseNotifier extends StateNotifier<AsyncValue<House?>> {
  final CreateHouseUseCase usecase;
  CreateHouseNotifier(this.usecase) : super(const AsyncData(null));

  Future<void> create(CreateHouseRequest name) async{
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => usecase(name));
  }
}