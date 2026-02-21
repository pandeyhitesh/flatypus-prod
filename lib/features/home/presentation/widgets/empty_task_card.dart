import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/task/presentation/methods/add_task_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget emptyTasksPlaceHolderCard(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'No tasks available.',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.white.withOpacity(.7),
          letterSpacing: .5,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        'Click on the button to create task',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.white.withOpacity(.5),
          letterSpacing: .5,
          fontWeight: FontWeight.w400,
        ),
      ),
      Consumer(
        builder:
            (context, ref, child) => Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 24,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    surfaceTintColor: kTransparent,
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed:
                      () => AddTaskMethods.openAddTaskScreenMethod(ref: ref),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
      ),
    ],
  );
}
