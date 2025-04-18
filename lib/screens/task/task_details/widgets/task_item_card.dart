import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/screens/home/widgets/space_name_tag.dart';
import 'package:flatypus/screens/task/add_task/widgets/assigned_user_card.dart';
import 'package:flatypus/screens/task/task_details/task_details_screen.dart';
import 'package:flatypus/screens/task/task_details/widgets/custom_task_schedule.dart';
import 'package:flatypus/state/providers/task_details_provider.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskItemCard extends ConsumerWidget {
  const TaskItemCard(
      {super.key,
      required this.task,
      required this.user,
      required this.spaceName});
  final TaskModel task;
  final UserModel? user;
  final String spaceName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(taskDetailsProvider.notifier).initiateTask(task);
        push(context, TaskDetailsScreen(task: task));
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
                taskSchedule: task.schedule, weekDays: task.weekDays),
            const SizedBox(height: 3),
            SizedBox(
              height: 26,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.assignment_ind_outlined,
                      size: 16, color: Colors.white60),
                  const SizedBox(width: 6),
                  AssignedUserCard(user: user)
                ],
              ),
            )
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
