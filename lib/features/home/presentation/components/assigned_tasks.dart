import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/app_screens.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/selected_page_controller.dart';
import 'package:flatypus/features/common/controllers/task_for_day_controller.dart';
import 'package:flatypus/features/common/widgets/component_header.dart';
import 'package:flatypus/features/common/widgets/custom_outline_navigation_button.dart';
import 'package:flatypus/features/common/widgets/custom_switch.dart';
import 'package:flatypus/features/home/presentation/widgets/assigned_task_card.dart';
import 'package:flatypus/features/home/presentation/widgets/empty_task_card.dart';
import 'package:flatypus/features/task/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignedTasks extends ConsumerWidget {
  const AssignedTasks({
    super.key,
    required this.title,
    this.userId,
    this.taskForDay = false,
  });
  final String title;
  final bool taskForDay;
  final String? userId;

  Future<List<TaskModel>> getSelectedTasks(WidgetRef ref) async {
    List<TaskModel> tasks = [];
    // TODO: implement taskprovider
    // final tasksFromProvider = ref.read(tasksProvider);
    final tasksFromProvider = <TaskModel>[];
    if (tasksFromProvider.isEmpty) return [];
    // if (!taskForDay) {
    //   final allTasks =
    //       await ref.read(tasksProvider.notifier).getTasksByhouseKey();
    //   tasks =
    //       allTasks
    //           .where((t) => t.scheduledDate?.isBefore(today) ?? false)
    //           .toList();
    // } else {
    //   final selfTasks = ref.read(taskForDayProvider);
    //   tasks = await ref
    //       .read(tasksProvider.notifier)
    //       .getFilteredTasks(date: today, selfTasks: [selfTasks]);
    // }
    return tasks;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: listen to task updates
    // ref.watch(tasksProvider);
    ref.listen(taskForDayProvider, (__, _) => getSelectedTasks(ref));

    return FutureBuilder(
      future: getSelectedTasks(ref),
      builder: (context, snapshot) {
        List<TaskModel> tasks = [];
        if (snapshot.hasData) {
          tasks = snapshot.data ?? [];
        }
        return Padding(
          padding: kHorizontalScrPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _sectionHeader(),
              const SizedBox(height: 16),
              if (snapshot.hasData)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 192,
                    child: _showTasksSection(context: context, tasks: tasks),
                  ),
                ),
              if (snapshot.hasError || !snapshot.hasData)
                _assignedTaskCard(child: emptyTasksPlaceHolderCard(context)),
            ],
          ),
        );
        if (snapshot.hasData) {
          final tasks = snapshot.data ?? [];
          return SizedBox(
            // height: 192,
            width: kScreenWidth,
            child: Padding(
              padding: kHorizontalScrPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _sectionHeader(),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 192,
                      child: _showTasksSection(context: context, tasks: tasks),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to fetch the Tasks'));
        }
        return const SizedBox();
        // return _assignedTaskCard(
        //   child: emptyTasksPlaceHolderCard(context),
        // );
      },
    );
  }

  Widget _showTasksSection({
    required BuildContext context,
    required List<TaskModel> tasks,
  }) {
    return (tasks.isEmpty)
        ? _assignedTaskCard(child: emptyTasksPlaceHolderCard(context))
        : _showAssignedTasks(context: context, tasks: tasks);
  }

  Widget _showAssignedTasks({
    required BuildContext context,
    required List<TaskModel> tasks,
  }) {
    return ListView.builder(
      itemCount: tasks.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AssignedTaskCard(task: tasks[index]);
      },
      padding: EdgeInsets.zero,
    );
  }

  Widget _assignedTaskCard({required Widget child}) => Container(
    height: 192,
    width: 128,
    decoration: BoxDecoration(
      borderRadius: kBorderRadius,
      color: AppColors.primaryColor,
    ),
    margin: const EdgeInsets.only(right: 12),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: child,
    ),
  );

  Widget _sectionHeader() {
    return SizedBox(
      width: kScreenWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          componentHeader(title),
          if (taskForDay)
            SizedBox(
              child: Consumer(
                builder: (context, ref, child) {
                  final controller = ref.watch(taskForDayProvider);
                  return CustomSwitch(
                    ref: ref,
                    controller: controller,
                    provider: taskForDayProvider,
                    activeText: 'My Tasks',
                    inactiveText: 'All Tasks',
                  );
                },
              ),
            ),
          if (!taskForDay)
            SizedBox(
              child: Consumer(
                builder:
                    (context, ref, child) => CustomOutlineNavigationButton(
                      label: 'All Tasks',
                      foregroundColor: AppColors.white.withAlpha(200),
                      function: () {
                        ref.read(selectedPageProvider.notifier).state =
                            AppScreens.tasks.index;
                      },
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
