import 'package:flatypus/common/enums.dart';
import 'package:flatypus/models/task_history_model.dart';
import 'package:flatypus/screens/task/task_details/methods/task_assign.dart';
import 'package:flatypus/services/firestore/task_service.dart';
import 'package:flatypus/state/providers/task_history_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/task_model.dart';
import '../providers/house_provider.dart';

class TasksNotifier extends StateNotifier<List<TaskModel>> {
  TasksNotifier(this.ref) : super([]) {
    getTasksByhouseKey();
  }

  final Ref ref;

  Future<List<TaskModel>> getTasksByhouseKey() async {
    ref.watch(houseProvider);
    final houseKey = ref.read(houseProvider)?.houseKey;
    final tasks = await TaskService().getTasksByhouseKey(houseKey: houseKey);
    if (!mounted) return [];
    state = tasks;
    return tasks.where((t) => t.active ?? false).toList();
  }

  Future<List<TaskModel>> getTasksBySpaceId({required String spaceId}) async {
    final tasks = await TaskService().getTasksBySpaceId(spaceId: spaceId);
    if (!mounted) return [];
    // state = tasks;
    return tasks.where((t) => t.active ?? false).toList();
  }

  Future<List<TaskModel>> getTasksByUser({String? userId}) async {
    final tasks = await TaskService().getTasksByUser(userId: userId);
    if (!mounted) return [];
    // state = tasks;
    return tasks.where((t) => t.active ?? false).toList();
  }

  Future<List<TaskModel>> getFilteredTasks(
      {bool selfTasks = false, required DateTime? date}) async {
    final tasks =
        await TaskService().getFilteredTasks(selfTasks: selfTasks, date: date);
    if (!mounted) return [];
    // state = tasks;
    return tasks.where((t) => t.active ?? false).toList();
  }

  Future<bool> addNewTask({required TaskModel task}) async {
    final result = await TaskService().addNewTaskToDB(task: task);
    if (result) state = [...state, task];
    return result;
  }

  Future<bool> deleteAllTasksBySpaceId({required String? spaceId}) async {
    final result =
        await TaskService().disableAllTasksBySpaceId(spaceId: spaceId);
    if (!result) return false;
    state = [...state]..removeWhere((tsk) => tsk.spaceId == spaceId);
    return result;
  }

  TaskModel? getTaskByTaskId(String? taskId) {
    if (taskId == null) return null;
    final index = state.indexWhere((tsk) => tsk.id == taskId);
    if (index == -1) return null;
    return state[index];
  }

  Future<bool> updateTaskDetails({required TaskModel task}) async {
    if (!mounted) return false;
    final result = await TaskService().updateTaskInDB(task: task);
    if (!result) return false;
    if (!mounted) return false;
    final index = state.indexWhere((tsk) => task.id == tsk.id);
    if (index == -1) return false;
    var taskList = [...state];
    taskList.removeAt(index);
    taskList.insert(index, task);
    state = taskList;
    return true;
  }

  Future<bool> updateTaskActivities(
      {required String taskId, required List<String> activities}) async {
    if (!mounted) return false;
    final index = state.indexWhere((tsk) => taskId == tsk.id);
    if (index == -1) return false;
    TaskModel task = [...state].elementAt(index);
    task = task.copyWith(activities: activities);
    return await updateTaskDetails(task: task);
  }

  Future<bool> updateTaskStatus(
      {required String taskId, required bool status}) async {
    try {
      final result = await TaskService()
          .updateStatusTaskInDB(taskId: taskId, status: status);
      if (!result) return false;
      final index = state.indexWhere((tsk) => taskId == tsk.id);
      if (index == -1) return false;
      var taskList = [...state];
      var task = taskList[index]..active = status;
      taskList.removeAt(index);
      taskList.insert(index, task);
      state = taskList;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTasksOnUserRemoval({required String userId}) async {
    try {
      final allTaskByUser = [...state]
        ..where((tsk) => tsk.assignedTo == userId);
      for (TaskModel task in allTaskByUser) {
        if (task.schedule == TaskSchedule.doNotRepeat) {
          // delete the task
          updateTaskStatus(taskId: task.id, status: false);
        } else {
          // assign task to next user
          final nextAssignedUser = await TaskAssign.getNextAssignedUser(
              notRef: ref, currentUserId: task.assignedTo);
          final updatedTask = task.copyWith(
            isCompleted: true,
            completedDate: DateTime.now(),
            completedBy: task.assignedTo,
            scheduledDate: TaskAssign.getNextScheduleDate(task: task),
            assignedTo: nextAssignedUser?.uid,
            isSkipped: false,
          );
          updateTaskDetails(task: updatedTask);
        }
        // add task history
        final taskHistory = TaskHistoryModel(
            id: '',
            userId: userId,
            spaceId: task.spaceId!,
            taskId: task.id,
            houseKey: task.houseKey!,
            completedDate: DateTime.now(),
            isSkipped: false,
            isDeleted: true);
        ref
            .read(taskHistoryProvider.notifier)
            .addNewTaskHistory(taskHistory: taskHistory);
      }
      return true;
    } catch (e) {}
    return false;
  }
}
