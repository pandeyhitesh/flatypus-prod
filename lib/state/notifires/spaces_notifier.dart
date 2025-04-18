import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/services/firestore/space_service.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpacesNotifier extends StateNotifier<List<SpaceModel>> {
  SpacesNotifier(this.ref) : super([]) {
    getSpacesByhouseKey();
  }

  final StateNotifierProviderRef ref;

  Future<void> getSpacesByhouseKey() async {
    ref.watch(houseProvider);
    final houseKey = ref.read(houseProvider)?.houseKey;
    final spaces = await SpaceService().getSpacesByhouseKey(houseKey: houseKey);
    if (!mounted) return;
    state = spaces;
  }

  Future<SpaceModel?> addNewSpaceToDB({required String spaceName}) async {
    final houseKey = ref.read(houseProvider)?.houseKey;
    final newSpaceObj = await SpaceService()
        .addNewSpaceToDB(spaceName: spaceName, houseKey: houseKey);
    if (newSpaceObj == null || !mounted) return null;
    state = [...state, newSpaceObj];
    return newSpaceObj;
  }

  Future<bool> deleteSpaceById({required String? spaceId}) async {
    final tskResult = await ref
        .read(tasksProvider.notifier)
        .deleteAllTasksBySpaceId(spaceId: spaceId);
    if (!tskResult) return false;
    final result = await SpaceService().deleteSpaceBySpaceId(spaceId: spaceId);
    if (!result) return false;
    state = [...state]..removeWhere((sp) => sp.id == spaceId);

    return result;
  }

  String? getSpaceNameBySpaceId(String? spaceId){
    if(spaceId == null) return null;
    final index = state.indexWhere((s)=>s.id == spaceId);
    if(index == -1) return null;
    return state[index].name;
  }
}
