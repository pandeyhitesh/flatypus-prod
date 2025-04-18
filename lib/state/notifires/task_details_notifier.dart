import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailsNotifier extends StateNotifier<TaskModel?> {
  TaskDetailsNotifier(this.ref) : super(null);

  final Ref ref;

  initiateTask(TaskModel? task) => state = task;

  /// Updates the task when marked as completed
  void updateTaskDetails(TaskModel updatedTask) {
    state = updatedTask;
  }

  /// Sync the state with the latest tasks from tasksProvider
  bool syncWithProvider() {
    final taskList = ref.read(tasksProvider);
    if (state == null) return true;
    final updatedTask = taskList.firstWhere(
      (tsk) => tsk.id == state?.id,
      orElse: () => state!,
    );
    if (updatedTask != state) {
      state = updatedTask;
      return true;
    }
    return false;
  }
}
