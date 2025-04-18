import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/screens/home/widgets/space_name_tag.dart';
import 'package:flatypus/screens/task/add_task/widgets/assigned_user_card.dart';
import 'package:flatypus/screens/task/task_details/task_details_screen.dart';
import 'package:flatypus/state/providers/task_details_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppointmentBuilder extends ConsumerWidget {
  const CustomAppointmentBuilder(
      {super.key,
      required this.task,
      required this.user,
      required this.spaces});
  final TaskModel task;
  final UserModel? user;
  final List<SpaceModel> spaces;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(taskDetailsProvider.notifier).initiateTask(task);
        push(context, TaskDetailsScreen(task: task));
      },
      child: Container(
        decoration: customCardDecoration(
          borderRadius: 8,
          bgColor: AppColors.secondaryColor.withAlpha(120),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: SpaceNameTag(
                    spaceName: taskSpace(spaces, task.spaceId),
                    isCompact: true,
                  )),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: AssignedUserCard(
                          user: user,
                          height: 20,
                          fontSize: 12,
                          initialsOnly: true)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
