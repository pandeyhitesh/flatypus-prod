import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/stacked_info.dart';
import 'package:flatypus/features/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/widgets/add_task/assigned_user_card.dart';
import 'package:flatypus/features/task/presentation/widgets/custom_task_schedule.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskScheduleCard extends ConsumerWidget {
  const TaskScheduleCard({
    super.key,
    required this.task,
    this.isDisplayOnly = false,
  });
  final TaskModel task;
  final bool isDisplayOnly;

  String taskSpace(spaces) =>
      spaces.firstWhere((sp) => sp.id == task.spaceId).name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: watch for spaceProvider
    // final spaces = ref.watch(spacesProvider);
    final spaces = <SpaceModel>[];
    final isActive = task.active ?? false;
    final statusLabel = isActive ? 'Open' : 'Closed';
    return InkWell(
      onTap:
          isDisplayOnly
              ? null
              : () {
                // TODO: get task details and route to task details screen
                // ref.read(taskDetailsProvider.notifier).initiateTask(task);
                // push(kGlobalContext, TaskDetailsScreen(task: task));
              },
      child: Container(
        decoration: isDisplayOnly ? kCardDecoration : kClickableCardDecoration,
        margin: const EdgeInsets.only(top: 12),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _taskTitle(task.name),
                  _scheduleDate(task.scheduledDate),
                  if (isDisplayOnly && spaces.isNotEmpty)
                    _taskHistorySpace(taskSpace(spaces)),
                  CustomTaskSchedule(
                    taskSchedule: task.schedule,
                    weekDays: task.weekDays,
                  ),
                  const SizedBox(height: 12),
                  _assignedToUser(uId: task.assignedTo),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            StackedInfo(
              label: statusLabel,
              iconColor:
                  isActive
                      ? StackedInfo.primaryIconColor
                      : StackedInfo.secondaryIconColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskTitle(String taskName) => Padding(
    padding: const EdgeInsets.only(top: 3, bottom: 8.0),
    child: Text(
      taskName,
      style: Theme.of(kGlobalContext).textTheme.titleLarge,
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _scheduleDate(DateTime? sdlDate) => textWithIconHeader(
    value: sdlDate == null ? 'N/A' : taskCardDateFormat.format(sdlDate),
    icon: Icons.calendar_month,
  );

  Widget _assignedToUser({required String? uId}) {
    if (uId == null) return const SizedBox(height: 14);
    return Consumer(
      builder: (context, ref, child) {
        // TODO: implement providers
        // ref.watch(usersProvider);
        // final user = ref.read(usersProvider.notifier).getUserByUid(uId);
        FlatypusUserModel? user;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Assigned To:',
              style: TextStyle(
                fontSize: 12,
                letterSpacing: .1,
                fontWeight: FontWeight.w400,
                color: AppColors.white.withOpacity(.9),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(height: 26, child: AssignedUserCard(user: user)),
          ],
        );
      },
    );
  }

  Widget _taskHistorySpace(String space) => textWithIconHeader(
    value: 'Space: $space',
    icon: Icons.living_rounded,
    fontSize: 14,
    iconSize: 18,
  );
}
