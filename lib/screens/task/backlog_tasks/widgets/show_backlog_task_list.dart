import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/empty_content_place_holder.dart';
import 'package:flatypus/screens/task/task_details/widgets/task_item_card.dart';
import 'package:flatypus/state/providers/spaces_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowBacklogTaskList extends ConsumerWidget {
  const ShowBacklogTaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backlogTasks = ref.watch(tasksProvider.select((allTasks) => allTasks
        .where((t) =>
            (t.scheduledDate?.isBefore(today) ?? false) && (t.active ?? false))
        .toList()));
    final spaces = ref.watch(spacesProvider);
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
                final user = ref
                    .read(usersProvider.notifier)
                    .getUserByUid(task.assignedTo);
                return TaskItemCard(
                    task: task,
                    user: user,
                    spaceName: taskSpace(spaces, task.spaceId));
              },
            )),
          if (backlogTasks.isEmpty)
            const Flexible(
                child: EmptyContentPlaceHolder(
              label: 'No Tasks available',
            ))
        ]);
  }
}
