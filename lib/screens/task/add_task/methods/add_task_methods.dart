import 'dart:developer' as dev;

import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/screens/house/methods/house_methods.dart';
import 'package:flatypus/screens/space/add_space_screen.dart';
import 'package:flatypus/services/global_context.dart';
import 'package:flatypus/state/controllers/schedule_selection_controller.dart';
import 'package:flatypus/state/controllers/space_selection_controller.dart';
import 'package:flatypus/state/controllers/task_assigned_to_controller.dart';
import 'package:flatypus/state/controllers/task_date_selection_controller.dart';
import 'package:flatypus/state/providers/house_provider.dart';
import 'package:flatypus/state/providers/spaces_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/snackbar.dart';
import '../../../../state/controllers/custom_week_days_selection.dart';
import '../add_task_screen.dart';

class AddTaskMethods {
  const AddTaskMethods._();

  static TaskModel getTaskObjectFromControllers({
    required WidgetRef ref,
    required String taskName,
  }) {
    final taskSchedule = ref.read(scheduleSectionControllerProvider);

    final task = TaskModel(
      id: '',
      name: taskName,
      assignedTo: ref.read(taskAssignedToProvider)?.uid,
      scheduledDate: ref.read(taskDateSelectionControllerProvider),
      schedule: taskSchedule,
      spaceId: ref.read(spaceSelectionControllerProvider)?.id,
      houseKey: ref.read(houseProvider)?.houseKey,
      weekDays: taskSchedule != TaskSchedule.customWeek
          ? null
          : ref.read(customWeekSelectionProvider),
      active: true,
    );
    return task;
  }

  static void addTaskButtonOnTap({
    required BuildContext context,
    required WidgetRef ref,
    required String taskName,
  }) async {
    final TaskModel newTask =
        getTaskObjectFromControllers(ref: ref, taskName: taskName);
    dev.log("New Task = $newTask");
    final result =
        await ref.read(tasksProvider.notifier).addNewTask(task: newTask);
    if (result && context.mounted) {
      showSuccessSnackbar(
        label: 'New task created successfully!',
      );
      pop();
    } else {
      showErrorSnackbar(
        label: 'Failed to create Task. Please try again',
      );
    }
  }

  static void openAddTaskScreenMethod({required WidgetRef ref}) {
    // check if house is added
    final isHouseAvailable = HouseMethods.isHouseAvailable(ref: ref);
    if(!isHouseAvailable) return;

    // Check if spaces are available
    final spaces = ref.read(spacesProvider);
    if (spaces.isEmpty) {
      //if No Space added, go to add space screen
      push(GlobalContext.navigationKey.currentContext!, AddSpaceScreen());
      showSuccessSnackbar(label: 'Please add a Space before adding task!');
    } else {
      //if space is available, go to add task screen
      ref.invalidate(spaceSelectionControllerProvider);
      ref.invalidate(scheduleSectionControllerProvider);
      ref.invalidate(customWeekSelectionProvider);
      ref.invalidate(taskDateSelectionControllerProvider);
      ref.invalidate(taskAssignedToProvider);
      push(GlobalContext.navigationKey.currentContext!, AddTaskScreen());
    }
  }
}
