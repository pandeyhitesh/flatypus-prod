import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/features/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/methods/task_assign_methods.dart';
import 'package:flatypus/features/task/presentation/widgets/add_task/assigned_user_card.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentAssigneeCard extends ConsumerWidget {
  const CurrentAssigneeCard({
    super.key,
    required this.task,
    this.bgColor,
    this.borderColor,
    this.isFutureAssignment = false,
  });

  final TaskModel task;
  final Color? bgColor;
  final Color? borderColor;
  final bool isFutureAssignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: kScreenWidth,
      decoration: customCardDecoration(
        bgColor: bgColor,
        borderColor: borderColor,
      ),
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: _scheduleDate(task.scheduledDate)),
                if (!isFutureAssignment)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: InkWell(
                      onTap: () {
                        TaskAssignMethods.updateTaskScheduleDate(
                          context: context,
                          ref: ref,
                          task: task,
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            _assignedToUser(ref: ref, uId: task.assignedTo),
            if (!isFutureAssignment)
              _manageScheduleButtonsSection(context, ref),
            if (isFutureAssignment) const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  Widget _scheduleDate(DateTime? sdlDate) => textWithIconHeader(
    value: sdlDate == null ? 'N/A' : taskCardDateFormat.format(sdlDate),
    icon: Icons.calendar_month,
    fontSize: 16,
    iconSize: 18,
  );

  Widget _assignedToUser({required WidgetRef ref, required String? uId}) {
    if (uId == null) return const SizedBox();
    // TODO: implement providers
    // ref.watch(usersProvider);
    // final user = ref.read(usersProvider.notifier).getUserByUid(uId);
    FlatypusUserModel? user;

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
  }

  Widget _manageScheduleButtonsSection(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 0, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextNIconButton(
              label: 'Skip Iteration',
              icon: Icons.skip_next_rounded,
              onTap:
                  () => TaskAssignMethods.markDoneButtonOnTap(
                    context: context,
                    ref: ref,
                    task: task,
                    isSkipped: true,
                  ),
              foregroundColor: AppColors.yellowAccent2,
            ),
            CustomTextNIconButton(
              label: 'Mark Done',
              icon: Icons.done_outline_rounded,
              onTap:
                  () => TaskAssignMethods.markDoneButtonOnTap(
                    context: context,
                    ref: ref,
                    task: task,
                  ),
              foregroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
