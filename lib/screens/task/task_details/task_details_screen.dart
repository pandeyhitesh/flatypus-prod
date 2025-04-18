import 'package:flatypus/common/enums.dart';
import 'package:flatypus/common/widgets/component_header.dart';
import 'package:flatypus/screens/space/widgets/task_schedule_card.dart';
import 'package:flatypus/screens/task/task_details/methods/task_assign.dart';
import 'package:flatypus/screens/task/task_details/widgets/current_assignee_card.dart';
import 'package:flatypus/screens/task/task_details/widgets/description_input.dart';
import 'package:flatypus/screens/task/task_details/widgets/task_details_menu.dart';
import 'package:flatypus/state/providers/task_details_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../common/methods.dart';
import '../../../models/task_model.dart';
import '../../../theme/app_colors.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});
  final TaskModel task;

  @override
  ConsumerState<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends ConsumerState<TaskDetailsScreen> {
  late TaskModel _task;
  List<TaskModel> nextTasks = [];

  get _appBar => AppBar(
        title: const Text('Task Details'),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
      );

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    if (_task.active ?? false) {
      getNextAssignments(widget.task);
    }
  }

  void getNextAssignments(TaskModel task) async {
    if (task.schedule == TaskSchedule.doNotRepeat) return;
    final nextTasksLocal =
        await TaskAssign.getNextAssignments(ref: ref, currentTask: task);
    setState(() {
      nextTasks = nextTasksLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskDetailsProvider);
    final taskNotifier = ref.read(taskDetailsProvider.notifier);

    ref.listen(
      tasksProvider,
      (previous, next) {
        taskNotifier.syncWithProvider();
        if (task != null && (task.active ?? false) && task.schedule != TaskSchedule.doNotRepeat) {
          getNextAssignments(task);
        }
      },
    );

    return Scaffold(
      appBar: _appBar,
      backgroundColor: kBackgroundColor,
      floatingActionButton: TaskDetailsMenu(
        task: task,
        taskStatus: task?.active,
      ),
      body: SafeArea(
        child: SizedBox(
          height: kScreenHeight,
          width: kScreenWidth,
          child: SingleChildScrollView(
            child: Padding(
              padding: kHorizontalScrPadding,
              child: task != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskScheduleCard(task: task, isDisplayOnly: true),

                        // If task is active,
                        //show task assignment details <active>
                        if (task.active ?? false) ...[
                          // current assignee
                          const SizedBox(height: 24),
                          componentHeader('Current Assignee'),
                          CurrentAssigneeCard(
                            task: task,
                            bgColor: AppColors.secondaryColor.withAlpha(180),
                            borderColor: AppColors.yellowAccent2,
                          ),

                          //Task Description
                          // current assignee
                          const SizedBox(height: 28),
                          componentHeader('Task Activities'),
                          Flexible(
                              child: UnorderedListInputScreen(
                                  taskId: task.id,
                                  activities: task.activities ?? [])),

                          // next assignment
                          const SizedBox(height: 28),
                          if (task.schedule != TaskSchedule.doNotRepeat) ...[
                            componentHeader('Next Assignees'),
                            ...showNextAssignments(),
                          ]
                        ], //</active>
                        const SizedBox(height: 150),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> showNextAssignments() {
    if (nextTasks.isEmpty) {
      return [
        const Text(
          'No Nxt tasks.',
          style: TextStyle(color: Colors.white),
        )
      ];
    }
    return [
      CurrentAssigneeCard(
        task: nextTasks.first,
        bgColor: AppColors.primaryColor,
        isFutureAssignment: true,
      ),

      // next assignment
      // const SizedBox(height: 24),
      CurrentAssigneeCard(
        task: nextTasks.last,
        bgColor: AppColors.primaryColor,
        isFutureAssignment: true,
      ),
    ];
  }
}
