import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/common/widgets/custom_icon_button.dart';
import 'package:flatypus/features/common/widgets/custom_text_n_icon_button.dart';
import 'package:flatypus/features/common/widgets/empty_content_place_holder.dart';
import 'package:flatypus/features/space/data/models/space_model.dart';
import 'package:flatypus/features/space/presentation/methods/space_methods.dart';
import 'package:flatypus/features/space/presentation/widgets/task_schedule_card.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageSpaceScreen extends ConsumerWidget {
  const ManageSpaceScreen({super.key, required this.space});

  final SpaceModel space;

  get _appBar => AppBar(
    title: Text(space.name),
    centerTitle: true,
    backgroundColor: kBackgroundColor,
    // toolbarHeight: 56,
    // bottom: PreferredSize(
    //   preferredSize: Size(kScreenWidth, 50),
    //   child: Center(
    //     child: Container(
    //       // height: 20,
    //       width: kScreenWidth,
    //       color: Colors.white70,
    //       // child: Center(child: Text('Hello')),
    //     ),
    //   ),
    // ),
    // actions: [
    //   Padding(
    //     padding: const EdgeInsets.only(right: 8.0),
    //     child: IconButton(
    //       onPressed: () => push(
    //         GlobalContext.navigationKey.currentContext!,
    //         AddSpaceScreen(),
    //       ),
    //       icon: const Icon(
    //         Icons.add_business_outlined,
    //         color: AppColors.white,
    //
    //       ),
    //       tooltip: 'Add new Space',
    //     ),
    //   ),
    // ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement get all tasks for space
    // final allTasks = ref.watch(tasksProvider);
    final allTasks = <TaskModel>[];
    // TODO: Implement get tasks for space
    final tasksForSpace =
        allTasks
            .where(
              (tsk) => tsk.spaceId == space.id && tsk.scheduledDate != null,
            )
            .toList();
    tasksForSpace.sort((a, b) => a.scheduledDate!.compareTo(b.scheduledDate!));
    // log("selected tasks = $tasksForSpace");
    return Scaffold(
      appBar: _appBar,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: kScreenHeight,
          width: kScreenWidth,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(kScreenPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _manageButtonSection(context: context, ref: ref),
                      ..._currentSchedule(tasks: tasksForSpace),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _manageButtonSection({
    required BuildContext context,
    required WidgetRef ref,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomIconButton(
        icon: Icons.history,
        onTap: () {
          // TODO: Implement get task history for space
          // ref.invalidate(taskHistoryFilterProvider);
          // push(context, TaskHistoryScreen(spaceId: space.id));
        },
        foregroundColor: AppColors.yellowAccent2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextNIconButton(
            label: 'Delete',
            icon: Icons.delete,
            onTap:
                () =>
                    SpaceMethods.onDeleteSpaceButtonTap(ref: ref, space: space),
            foregroundColor: AppColors.errorColor,
          ),
          CustomTextNIconButton(
            label: 'Add Task',
            icon: Icons.add_task,
            onTap:
                () => SpaceMethods.onAddTaskForSpaceButtonTap(
                  ref: ref,
                  space: space,
                ),
            foregroundColor: AppColors.yellowAccent2,
          ),
        ],
      ),
    ],
  );

  _currentSchedule({required List<TaskModel> tasks}) {
    return [
      const SizedBox(height: 24),
      componentHeader('Upcoming Schedule'),
      if (tasks.isNotEmpty) ...tasks.map((tsk) => TaskScheduleCard(task: tsk)),
      if (tasks.isEmpty)
        const Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: EmptyContentPlaceHolder(label: 'No Schedule available'),
        ),
      // ListView.builder(
      //   itemCount: tasks.length,
      //   itemBuilder: (context, index) {
      //     return _taskScheduleCard(task: tasks[index]);
      //   },
      // ),
    ];
  }

  // _taskScheduleCard({
  //   required TaskModel task,
  // }) {
  //   return InkWell(
  //     onTap: ()=>push(kGlobalContext, TaskDetailsScreen(task: task)),
  //     child: Container(
  //       decoration: kCardDecoration,
  //       margin: const EdgeInsets.only(top: 12),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             _taskTitle(task.name),
  //             _scheduleDate(task.scheduledDate),
  //             _scheduleFrequency(task),
  //             const SizedBox(height: 12),
  //             _assignedToUser(uId: task.assignedTo),
  //             const SizedBox(height: 4),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
