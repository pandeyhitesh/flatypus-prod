import 'dart:developer' as dev;

import 'package:flatypus/core/services/global_context.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/core/utils/snackbar.dart';
import 'package:flatypus/features/common/controllers/custom_week_days_selection.dart';
import 'package:flatypus/features/common/controllers/schedule_selection_controller.dart';
import 'package:flatypus/features/common/controllers/space_selection_controller.dart';
import 'package:flatypus/features/common/controllers/task_assigned_to_controller.dart';
import 'package:flatypus/features/common/controllers/task_date_selection_controller.dart';
import 'package:flatypus/features/house/presentation/methods/house_methods.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/space/presentation/pages/add_space_screen.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      assignedTo: ref.read(taskAssignedToProvider)?.id,
      scheduledDate: ref.read(taskDateSelectionControllerProvider),
      schedule: taskSchedule,
      spaceId: ref.read(spaceSelectionControllerProvider)?.id,
      // TODO: get house key from provider and add
      // houseKey: ref.read(houseProvider)?.houseKey,
      weekDays:
          taskSchedule != TaskSchedule.customWeek
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
    final TaskModel newTask = getTaskObjectFromControllers(
      ref: ref,
      taskName: taskName,
    );
    dev.log("New Task = $newTask");
    // TODO: add task to provider
    // final result = await ref
    //     .read(tasksProvider.notifier)
    //     .addNewTask(task: newTask);
    // if (result && context.mounted) {
    //   showSuccessSnackbar(label: 'New task created successfully!');
    //   pop();
    // } else {
    //   showErrorSnackbar(label: 'Failed to create Task. Please try again');
    // }
  }

  static void openAddTaskScreenMethod({required WidgetRef ref}) {
    // check if house is added
    final isHouseAvailable = HouseMethods.isHouseAvailable(ref: ref);
    if (!isHouseAvailable) return;

    // Check if spaces are available
    //TODO: implement spaces provider
    // final spaces = ref.read(spacesProvider);
    final spaces = <SpaceModel>[];
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
      //TODO: route to add task screen
      // push(GlobalContext.navigationKey.currentContext!, AddTaskScreen());
    }
  }
}
