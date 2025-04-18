import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/screens/home/widgets/space_name_tag.dart';
import 'package:flatypus/screens/home/widgets/user_profile_image.dart';
import 'package:flatypus/screens/task/task_details/task_details_screen.dart';
import 'package:flatypus/state/providers/spaces_provider.dart';
import 'package:flatypus/state/providers/task_details_provider.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flatypus/theme/borders.dart';
import 'package:flatypus/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/space_model.dart';

class AssignedTaskCard extends ConsumerWidget {
  const AssignedTaskCard({super.key, required this.task});
  final TaskModel task;

  String taskSpace(List<SpaceModel> spaces, String? spaceId) {
    if (spaces.isNotEmpty && spaceId != null) {
      return spaces.firstWhere((sp) => sp.id == spaceId).name;
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spaces = ref.watch(spacesProvider);
    // ref.watch(usersProvider);

    return Container(
      height: 192,
      width: 128,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   color: AppColors.primaryColor,
      // ),
      decoration: kClickableCardDecoration,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => {
          ref.read(taskDetailsProvider.notifier).initiateTask(task),
          push(context, TaskDetailsScreen(task: task))
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceNameTag(spaceName: taskSpace(spaces, task.spaceId)),
            _taskName(),
            _scheduleDate(),
            _assignedUserImage(ref),
          ],
        ),
      ),
    );
  }

  Widget _taskName() => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            task.name,
            style: taskNameTextStyle,
            maxLines: 3,
            // softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _scheduleDate() => Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month,
              size: 16,
              color: Colors.white60,
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(
                task.scheduledDate == null
                    ? 'N/A'
                    : taskCardDateFormat.format(task.scheduledDate!),
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: .1,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(.9),
                ),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );

  Widget _assignedUserImage(WidgetRef ref) {
    ref.watch(usersProvider);
    final user = ref.read(usersProvider.notifier).getUserByUid(task.assignedTo);
    if (user == null || user.photoURL == null) return const SizedBox();
    return userProfileImage(
      level: Level.small,
      photoURL: user.photoURL,
    );
  }
}

// Widget assignedTaskCard({
//   required BuildContext context,
//   required TaskModel task,
// }){
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         decoration: BoxDecoration(
//           borderRadius: kBorderRadius,
//           color: AppColors.yellowAccent,
//
//         ),
//         child: Text(task.),
//       ),
//     ],
//   );
// }
