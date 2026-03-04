import 'dart:developer' as dev;
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/house/data/model/user_order_model.dart';
import 'package:flatypus/features/house/domain/entities/user_order.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/enums.dart';

class TaskAssignMethods {
  const TaskAssignMethods._();

  static DateTime? getNextScheduleDate({required TaskModel task}) {
    final freq = task.schedule;
    final taskDate = task.scheduledDate ?? today;
    if (freq == null) return null;
    switch (freq) {
      case TaskSchedule.doNotRepeat:
        if (task.scheduledDate == null) return today;
        return null;
      case TaskSchedule.daily:
        return taskDate.add(const Duration(days: 1));
      case TaskSchedule.customWeek:
        final customWeekDays =
            task.weekDays?.where((d) => d.isSelected).toList();
        List<int>? selectedDays = customWeekDays?.map((d) => d.dayNo).toList();
        selectedDays?.sort();
        if (selectedDays == null) return null;
        final currentWeekDay = taskDate.weekday;
        // Find the next custom weekday after the current day
        for (int day in selectedDays) {
          if (day > currentWeekDay) {
            int daysUntilNext = day - currentWeekDay;
            return taskDate.add(Duration(days: daysUntilNext));
          }
        }
        // If no future day in the current week is found, use the first custom weekday in the next week
        int daysUntilNextWeek = 7 - currentWeekDay + selectedDays[0];
        return taskDate.add(Duration(days: daysUntilNextWeek));
      case TaskSchedule.alternateDays:
        return taskDate.add(const Duration(days: 2));
      case TaskSchedule.monthly:
        return DateTime(taskDate.year, taskDate.month + 1, taskDate.day);
    }
  }

  static Future<FlatypusUserModel?> getNextAssignedUser({
    WidgetRef? ref,
    Ref? notRef,
    required String? currentUserId,
  }) async {
    try {
      List<UserOrder>? userOrder;
      //TODO: Get user order from house provider
      // if (ref != null) {
      //   userOrder = ref.read(houseProvider)?.userOrder;
      // } else if (notRef != null) {
      //   userOrder = notRef.read(houseProvider)?.userOrder;
      // }
      if (userOrder == null || userOrder.isEmpty) return null;
      int nextUserIndex;
      if (currentUserId == null) {
        nextUserIndex = 0;
      }
      final cuIndex = userOrder.indexWhere((uo) => uo.uid == currentUserId);
      nextUserIndex = cuIndex == (userOrder.length - 1) ? 0 : cuIndex + 1;

      // TODO: get ID of next assigned user
      // if (ref != null) {
      //   return ref
      //       .read(usersProvider.notifier)
      //       .getUserByUid(userOrder[nextUserIndex].uid);
      // } else if (notRef != null) {
      //   return notRef
      //       .read(usersProvider.notifier)
      //       .getUserByUid(userOrder[nextUserIndex].uid);
      // }
    } catch (e) {
      dev.log(e.toString());
    }
    return null;
  }

  static Future<List<TaskModel>> getNextAssignments({
    required WidgetRef ref,
    required TaskModel currentTask,
  }) async {
    // get next Schedule

    try {
      DateTime? nextDate1;
      while (!(nextDate1?.isAfter(today) ?? false)) {
        nextDate1 = getNextScheduleDate(
          task: currentTask.copyWith(scheduledDate: nextDate1),
        );
      }
      final assignedTo1 = await getNextAssignedUser(
        ref: ref,
        currentUserId: currentTask.assignedTo!,
      );
      if (nextDate1 == null) return [];
      final task1 = currentTask.copyWith(
        scheduledDate: nextDate1,
        assignedTo: assignedTo1?.id,
      );
      // get 2nd next schedule
      DateTime? nextDate2;
      while (!(nextDate2?.isAfter(today) ?? false)) {
        nextDate2 = getNextScheduleDate(task: task1);
      }
      final assignedTo2 = await getNextAssignedUser(
        ref: ref,
        currentUserId: task1.assignedTo!,
      );
      if (nextDate2 == null) return [];
      final task2 = currentTask.copyWith(
        scheduledDate: nextDate2,
        assignedTo: assignedTo2?.id,
      );
      return [task1, task2];
    } catch (e) {
      dev.log("Error: getNextAssignments. Details: $e");
    }
    return [];
  }

  static void markDoneButtonOnTap({
    required BuildContext context,
    required WidgetRef ref,
    required TaskModel task,
    bool isSkipped = false,
  }) async {
    try {
      final nextAssignedUser = await getNextAssignedUser(
        ref: ref,
        currentUserId: task.assignedTo,
      );
      final updatedTask = task.copyWith(
        completedDate: DateTime.now(),
        completedBy: task.assignedTo,
        scheduledDate: getNextScheduleDate(task: task),
        assignedTo: nextAssignedUser?.id,
        isSkipped: isSkipped,
      );
      dev.log('Updated Task request = $updatedTask');

      // TODO: mark task done with update task details

      // final result = await ref
      //     .read(tasksProvider.notifier)
      //     .updateTaskDetails(task: updatedTask);

      // ref.read(provider)
      // if (result) {
      //   ref.read(taskDetailsProvider.notifier).updateTaskDetails(updatedTask);
      //   final taskHistory = TaskHistoryModel(
      //     id: '',
      //     userId: task.assignedTo!,
      //     spaceId: task.spaceId!,
      //     taskId: task.id,
      //     houseKey: task.houseKey!,
      //     completedDate: task.completedDate ?? DateTime.now(),
      //     isSkipped: isSkipped,
      //     isDeleted: false,
      //   );
      //   ref
      //       .read(taskHistoryProvider.notifier)
      //       .addNewTaskHistory(taskHistory: taskHistory);
      //   // -- if task is an one time task,
      //   // -- then disable the task
      //   if (task.schedule == TaskSchedule.doNotRepeat) {
      //     if (context.mounted) {
      //       TaskMenuMethods.markTaskAsClosed(
      //         context: context,
      //         ref: ref,
      //         task: task,
      //       );
      //     }
      //   }
      //   showSuccessSnackbar(
      //     label:
      //         isSkipped
      //             ? 'Task skipped successfully'
      //             : 'Task marked done successfully!',
      //   );
      // } else {
      //   showErrorSnackbar(label: 'Failed to update Task. Please try again');
      // }
    } catch (e) {
      dev.log('Failed to Mark task as Done. Error : $e');
    }
  }

  static void updateTaskScheduleDate({
    required BuildContext context,
    required WidgetRef ref,
    required TaskModel task,
  }) async {
    try {
      // TODO: implement UPDATE TASK SCHEDULE DATE
      // DateTime? initialDate = task.scheduledDate;
      // if ((initialDate?.isBefore(today) ?? false) ||
      //     (initialDate?.isAfter(lastAllowedFutureDate) ?? false)) {
      //   initialDate = today;
      // }
      // ref.read(taskDateSelectionControllerProvider.notifier).state =
      //     initialDate;
      // final selectedDate = await selectDateFromCalendar(
      //   context: context,
      //   ref: ref,
      //   dateController: taskDateSelectionControllerProvider,
      // );
      // if (selectedDate == null) return;
      // TaskModel updatedTask = task.copyWith(scheduledDate: selectedDate);
      // final result = await ref
      //     .read(tasksProvider.notifier)
      //     .updateTaskDetails(task: updatedTask);

      // if (result) {
      //   ref.read(taskDetailsProvider.notifier).updateTaskDetails(updatedTask);
      //   showSuccessSnackbar(label: 'Task Scheduled Date updated successfully!');
      // } else {
      //   throw Exception('Failed to update Task. Please try again');
      // }
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
