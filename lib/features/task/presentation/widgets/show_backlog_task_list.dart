import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/empty_content_place_holder.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flatypus/features/task/presentation/widgets/task_item_card.dart';
import 'package:flatypus/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowBacklogTaskList extends ConsumerWidget {
  const ShowBacklogTaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement providers
    // final backlogTasks = ref.watch(tasksProvider.select((allTasks) => allTasks
    //     .where((t) =>
    //         (t.scheduledDate?.isBefore(today) ?? false) && (t.active ?? false))
    //     .toList()));
    // final spaces = ref.watch(spacesProvider);
    final backlogTasks = <TaskModel>[];
    final spaces = <SpaceModel>[];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (backlogTasks.isNotEmpty)
          Flexible(
            child: ListView.builder(
              itemCount: backlogTasks.length + 1,
              itemBuilder: (context, index) {
                if (backlogTasks.length == index) {
                  return const SizedBox(height: 150);
                }
                final task = backlogTasks[index];
                // TODO: implement provider
                // final user = ref
                //     .read(usersProvider.notifier)
                //     .getUserByUid(task.assignedTo);
                UserModel? user;
                return TaskItemCard(
                  task: task,
                  user: user,
                  spaceName: taskSpace(spaces, task.spaceId),
                );
              },
            ),
          ),
        if (backlogTasks.isEmpty)
          const Flexible(
            child: EmptyContentPlaceHolder(label: 'No Tasks available'),
          ),
      ],
    );
  }
}
