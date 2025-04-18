import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/empty_content_place_holder.dart';
import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/screens/task/task_details/widgets/task_item_card.dart';
import 'package:flatypus/screens/task/tasks/widget/custom_calendar_timeline.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowTimelineTasks extends ConsumerWidget {
  const ShowTimelineTasks(
      {super.key,
      required this.selectedTasks,
      required this.spaces,
      required this.timelineCalendarController});
  final List<TaskModel> selectedTasks;
  final List<SpaceModel> spaces;
  final DatePickerController timelineCalendarController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCalendarTimeline(
            timelineCalendarController: timelineCalendarController,
          ),
          if (selectedTasks.isNotEmpty)
            Flexible(
                child: ListView.builder(
              itemCount: selectedTasks.length + 1,
              itemBuilder: (context, index) {
                if (selectedTasks.length == index) {
                  return const SizedBox(height: 150);
                }
                final task = selectedTasks[index];
                final user = ref
                    .read(usersProvider.notifier)
                    .getUserByUid(task.assignedTo);
                return TaskItemCard(
                    task: task,
                    user: user,
                    spaceName: taskSpace(spaces, task.spaceId));
              },
            )),
          if (selectedTasks.isEmpty)
            const Flexible(
                child: EmptyContentPlaceHolder(
              label: 'No Tasks available',
            ))
        ]);
  }
}
