import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/home/presentation/widgets/space_name_tag.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/widgets/add_task/assigned_user_card.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flatypus/features/home/presentation/widgets/assigned_task_card.dart';

class CustomAppointmentBuilder extends ConsumerWidget {
  const CustomAppointmentBuilder({
    super.key,
    required this.task,
    required this.user,
    required this.spaces,
  });
  final TaskModel task;
  final UserModel? user;
  final List<SpaceModel> spaces;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // TODO: implement providers
        // ref.read(taskDetailsProvider.notifier).initiateTask(task);
        // push(context, TaskDetailsScreen(task: task));
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
              Text(task.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SpaceNameTag(
                      spaceName: taskSpace(spaces, task.spaceId),
                      isCompact: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: AssignedUserCard(
                      user: user,
                      height: 20,
                      fontSize: 12,
                      initialsOnly: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
