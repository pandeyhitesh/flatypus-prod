import 'package:flatypus/models/task_history_model.dart';
import 'package:flatypus/screens/profile/task_history/widgets/filter_action_checklist.dart';
import 'package:flatypus/services/firestore/task_history_service.dart';
import 'package:flatypus/state/controllers/task_history_filter_controller.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskHistoryNotifier extends StateNotifier<List<TaskHistoryModel>> {
  TaskHistoryNotifier(this.ref) : super([]) {
    _init();
  }

  final StateNotifierProviderRef ref;

  void _init() {
    // Listen for filter changes
    ref.listen(taskHistoryFilterProvider, (_, __) {
      applyFilter();
    });

    getTaskHistoryByHouseKey();
  }

  Future<List<TaskHistoryModel>> getTaskHistoryByHouseKey() async {
    ref.watch(houseProvider);
    final houseKey = ref.read(houseProvider)?.houseKey;
    List<TaskHistoryModel> tasksHistory =
        await TaskHistoryService().getTaskHistoryByHouseKey(houseKey: houseKey);
    if (!mounted) return [];
    _originalTasks = tasksHistory;
    return applyFilter();
  }

  Future<List<TaskHistoryModel>> getTaskHistoryBySpaceId(
      {required String spaceId}) async {
    final tasksHistory =
        await TaskHistoryService().getTaskHistoryBySpaceId(spaceId: spaceId);
    if (!mounted) return [];
    _originalTasks = tasksHistory;
    return applyFilter();
  }

  List<TaskHistoryModel> _originalTasks = [];

  List<TaskHistoryModel> applyFilter() {
    final taskFilter = ref.read(taskHistoryFilterProvider);

    List<TaskHistoryModel> filteredTasks = _originalTasks.where((task) {
      final showSkipped = taskFilter[TaskFilter.skipped] ?? false;
      final showDeleted = taskFilter[TaskFilter.deleted] ?? false;

      if (showSkipped && task.isSkipped) return true;
      if (showDeleted && task.isDeleted) return true;

      return (!showSkipped && !showDeleted)
          ? !(task.isSkipped || task.isDeleted)
          : false;
    }).toList();

    state = filteredTasks;
    return filteredTasks;
  }

  Future<bool> addNewTaskHistory(
      {required TaskHistoryModel taskHistory}) async {
    final result = await TaskHistoryService()
        .addNewTaskHistoryToDB(taskHistory: taskHistory);
    if (result) state = [...state, taskHistory];
    return result;
  }
}
