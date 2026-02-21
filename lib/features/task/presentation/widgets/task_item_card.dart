import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/theme/textstyles.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/features/home/presentation/widgets/space_name_tag.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/widgets/add_task/assigned_user_card.dart';
import 'package:flatypus/features/task/presentation/widgets/custom_task_schedule.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskItemCard extends ConsumerWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.user,
    required this.spaceName,
  });
  final TaskModel task;
  final UserModel? user;
  final String spaceName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // TODO: implement providers
        // ref.read(taskDetailsProvider.notifier).initiateTask(task);
        // push(context, TaskDetailsScreen(task: task));
      },
      child: Container(
        decoration: kClickableCardDecoration,
        padding: kTaskCardPadding,
        margin: kTaskCardMargin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: taskNameTextStyle,
              maxLines: 2,
              // softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            SpaceNameTag(spaceName: spaceName),
            const SizedBox(height: 6),
            _scheduleDate(task.scheduledDate),
            CustomTaskSchedule(
              taskSchedule: task.schedule,
              weekDays: task.weekDays,
            ),
            const SizedBox(height: 3),
            SizedBox(
              height: 26,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.assignment_ind_outlined,
                    size: 16,
                    color: Colors.white60,
                  ),
                  const SizedBox(width: 6),
                  AssignedUserCard(user: user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scheduleDate(DateTime? sdlDate) => textWithIconHeader(
    value: sdlDate == null ? 'N/A' : taskCardDateFormat.format(sdlDate),
    icon: Icons.calendar_month,
    fontSize: 13,
    iconSize: 16,
  );
}
