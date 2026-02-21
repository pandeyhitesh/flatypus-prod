import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/theme/textstyles.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/home/presentation/widgets/space_name_tag.dart';
import 'package:flatypus/features/home/presentation/widgets/user_profile_image.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // TODO: implement space provider
    // final spaces = ref.watch(spacesProvider);
    //// ref.watch(usersProvider);
    final spaces = <SpaceModel>[];

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
        onTap:
            () => {
              // TODO: implement the providers
              // ref.read(taskDetailsProvider.notifier).initiateTask(task),
              // push(context, TaskDetailsScreen(task: task)),
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
        const Icon(Icons.calendar_month, size: 16, color: Colors.white60),
        const SizedBox(width: 6),
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
    // TODO: implement photo URL
    // ref.watch(usersProvider);
    // final user =
    //     task.assignedTo != null
    //         ? ref.read(usersProvider.notifier).getUserByUid(task.assignedTo!)
    //         : null;
    // if (user == null || user.photoURL == null) return const SizedBox();
    // return userProfileImage(level: Level.small, photoURL: user.photoURL);
    return userProfileImage(level: Level.small, photoURL: '');
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
