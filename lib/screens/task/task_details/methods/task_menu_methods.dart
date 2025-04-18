import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/screens/task/task_details/methods/task_assign.dart';
import 'package:flatypus/state/providers/task_details_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskMenuMethods {
  // static void updateTaskState(
  //     {required WidgetRef ref,
  //     required String taskId,
  //     required bool taskStatus}) async {
  //   final result = await ref
  //       .read(tasksProvider.notifier)
  //       .updateTaskStatus(taskId: taskId, status: taskStatus);
  //   if (result) {
  //     showSuccessSnackbar(label: 'Task status updated successfully!');
  //   } else {
  //     showErrorSnackbar(label: 'Failed to update the task status!');
  //   }
  // }

  // Mark the Task as Closed
  static Future<void> markTaskAsClosed({
    required BuildContext context,
    required WidgetRef ref,
    required TaskModel task,
  }) async {
    try {
      final updatedTask = task.copyWith(
        copyExact: true,
        active: false,
        completedDate: DateTime.now(),
        completedBy: task.assignedTo,
        scheduledDate: null,
        assignedTo: null,
      );

      final result = await ref
          .read(tasksProvider.notifier)
          .updateTaskDetails(task: updatedTask);

      // ref.read(provider)
      if (result) {
        ref.read(taskDetailsProvider.notifier).updateTaskDetails(updatedTask);
        showSuccessSnackbar(
          label: 'Task is now closed!',
        );
      } else {
        throw Exception('Failed to update Task. Please try again');
      }
    } catch (e) {
      showErrorSnackbar(
        label: 'Failed to update Task. Please try again',
      );
    }
  }

  // Mark the Task as Open
  static Future<void> markTaskAsOpen({
    required BuildContext context,
    required WidgetRef ref,
    required TaskModel task,
  }) async {
    try {
      final nextAssignedUser =
      await TaskAssign.getNextAssignedUser(ref: ref, currentUserId: task.assignedTo);
      final updatedTask = task.copyWith(
        active: true,
        completedDate: DateTime.now(),
        completedBy: task.assignedTo,
        scheduledDate: TaskAssign.getNextScheduleDate(task: task),
        assignedTo: nextAssignedUser?.uid,
      );

      final result = await ref
          .read(tasksProvider.notifier)
          .updateTaskDetails(task: updatedTask);

      // ref.read(provider)
      if (result) {
        ref.read(taskDetailsProvider.notifier).updateTaskDetails(updatedTask);
        showSuccessSnackbar(
          label: 'Task is now Open!',
        );
      } else {
        throw Exception('Failed to update Task. Please try again');
      }
    } catch (e) {
      showErrorSnackbar(
        label: 'Failed to update Task. Please try again',
      );
    }
  }
}
