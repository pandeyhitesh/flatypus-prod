import 'package:flatypus/common/widgets/stacked_info.dart';
import 'package:flatypus/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/models/task_history_model.dart';
import 'package:flatypus/screens/task/add_task/widgets/assigned_user_card.dart';
import 'package:flatypus/state/providers/spaces_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/methods.dart';
import '../../../../state/providers/users_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/borders.dart';

class TaskHistoryItemCard extends ConsumerWidget {
  const TaskHistoryItemCard({
    super.key,
    required this.task,
    this.bgColor,
    this.borderColor,
    this.isFutureAssignment = false,
  });

  final TaskHistoryModel task;
  final Color? bgColor;
  final Color? borderColor;
  final bool isFutureAssignment;

  String taskSpace(List spaces) {
    final space = spaces.indexWhere((sp) => sp.id == task.spaceId);
    if (space != -1) {
      return spaces[space].name;
    } else {
      return 'Deleted Space';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spaces = ref.watch(spacesProvider);
    final taskObject = ref
        .read(tasksProvider.notifier)
        .getTaskByTaskId(task.taskId);
    return Container(
      decoration: customCardDecoration(
        bgColor: bgColor,
        borderColor: borderColor,
      ),
      margin: const EdgeInsets.only(top: 12),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _taskName(taskObject?.name),
                _completedDate(task.completedDate),
                const SizedBox(height: 3),
                _taskHistorySpace(taskSpace(spaces)),
                const SizedBox(height: 5),
                _assignedToUser(uId: task.userId),
                if (isFutureAssignment) const SizedBox(height: 3),
              ],
            ),
          ),
          if (task.isDeleted)
            StackedInfo(
              label: 'Deleted',
              iconColor: AppColors.white.withAlpha(200),
              iconData: Icons.delete,
              position: StackedInfo.topRightPosition,
              textPaddingRight: 3,
              backgroundColor: AppColors.errorColor.withAlpha(200),
              textColor: AppColors.white.withAlpha(200),
            ),
          if (task.isSkipped && !task.isDeleted)
            const StackedInfo(
              label: 'Skipped',
              iconColor: StackedInfo.secondaryIconColor,
              iconData: Icons.skip_next,
              position: StackedInfo.topRightPosition,
              textPaddingRight: 3,
            ),
        ],
      ),
    );
  }

  Widget _completedDate(DateTime sdlDate) => textWithIconHeader(
    value: 'Completed On: ${taskCardDateFormat.format(sdlDate)}',
    icon: Icons.calendar_month,
    fontSize: 14,
    iconSize: 18,
  );

  Widget _taskHistorySpace(String space) => textWithIconHeader(
    value: 'Space: $space',
    icon: Icons.living_rounded,
    fontSize: 14,
    iconSize: 18,
  );

  Widget _assignedToUser({required String? uId}) {
    if (uId == null) return const SizedBox();
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(usersProvider);
        final user = ref.read(usersProvider.notifier).getUserByUid(uId);

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_ind_outlined,
              size: 18,
              color: Colors.white60,
            ),
            const SizedBox(width: 6),
            SizedBox(height: 26, child: AssignedUserCard(user: user)),
          ],
        );
      },
    );
  }

  Widget _taskName(String? name) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      name ?? 'N/A',
      style: TextStyle(
        fontSize: 18,
        letterSpacing: .1,
        fontWeight: FontWeight.w400,
        color: AppColors.white.withOpacity(.9),
        height: 1.2,
      ),
      maxLines: 3,
      // softWrap: false,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
