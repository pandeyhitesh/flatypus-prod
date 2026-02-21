import 'package:flatypus/core/di/injector.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/presentation/providers/notifiers/create_house_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createHouseProvider = StateNotifierProvider<CreateHouseNotifier, AsyncValue<House?>>(
  (ref) => CreateHouseNotifier(ref.read(createHouseUsecaseProvider)),
);

final getHouseProvider = FutureProvider.family<House, String>((ref, id){
  return ref.read(getHouseUsecaseProvider)(id);
});