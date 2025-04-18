import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/screens/task/task_details/methods/task_menu_methods.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TaskDetailsMenu extends ConsumerWidget {
  const TaskDetailsMenu({
    super.key,
    required this.task,
    required this.taskStatus,
  });
  final TaskModel? task;
  final bool? taskStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (task == null || taskStatus == null) return const SizedBox();
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme:
          const IconThemeData(color: AppColors.backgroundColor, size: 28.0),
      backgroundColor: AppColors.secondaryColor,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        taskStatus!
            ? _menuItem(
                context, ref, task!, taskStatus!, Icons.block, 'Close Task')
            : _menuItem(context, ref, task!, taskStatus!, Icons.restart_alt,
                'Re-open Task'),
      ],
    );
  }

  SpeedDialChild _menuItem(BuildContext context, WidgetRef ref, TaskModel task,
          bool taskStatus, IconData icon, String label) =>
      SpeedDialChild(
          child: Icon(icon, color: Colors.white),
          backgroundColor: AppColors.yellowAccent2,
          onTap: () async{
            if (taskStatus) {
              await TaskMenuMethods.markTaskAsClosed(
                  ref: ref, context: context, task: task);
            } else {
              await TaskMenuMethods.markTaskAsOpen(
                  ref: ref, context: context, task: task);
            }
          },
          label: label,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: AppColors.primaryColor);
}
