import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/widgets/empty_content_place_holder.dart';
import 'package:flatypus/models/task_history_model.dart';
import 'package:flatypus/screens/profile/task_history/widgets/filter_action_checklist.dart';
import 'package:flatypus/screens/profile/task_history/widgets/filter_item.dart';
import 'package:flatypus/screens/profile/task_history/widgets/task_history_item_card.dart';
import 'package:flatypus/state/controllers/task_history_filter_controller.dart';
import 'package:flatypus/state/providers/task_history_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskHistoryScreen extends ConsumerWidget {
  const TaskHistoryScreen({super.key, this.spaceId});
  final String? spaceId;

  get _appBar => AppBar(
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kTransparent,
        title: const Text('Task History'),
        centerTitle: true,
        // actions: filterActionCheckList(),
      );

  void _onDeletedButtonTap(WidgetRef ref) {
    Map<TaskFilter, bool> filter = ref.read(taskHistoryFilterProvider);
    final isDeleted = filter[TaskFilter.deleted] ?? false;
    ref
        .read(taskHistoryFilterProvider.notifier)
        .updateFilter(TaskFilter.deleted, !isDeleted);
  }

  void _onSkippedButtonTap(WidgetRef ref) {
    Map<TaskFilter, bool> filter = ref.read(taskHistoryFilterProvider);
    final isSkipped = filter[TaskFilter.skipped] ?? false;
    ref
        .read(taskHistoryFilterProvider.notifier)
        .updateFilter(TaskFilter.skipped, !isSkipped);
  }

  List<TaskHistoryModel> _getTaskList(WidgetRef ref) {
    final historyByHouseKey = ref.read(taskHistoryProvider);
    List<TaskHistoryModel> taskHistory = [];
    if (spaceId == null) {
      taskHistory = historyByHouseKey.toList();
    } else {
      final historyBySpaceId =
          historyByHouseKey.where((th) => th.spaceId == spaceId).toList();
      taskHistory = historyBySpaceId.toList();
    }
    return taskHistory;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyByHouseKey = ref.watch(taskHistoryProvider);
    final filterController = ref.watch(taskHistoryFilterProvider);
    List<TaskHistoryModel> taskHistory = _getTaskList(ref);
    ref.listen(
      taskHistoryFilterProvider,
      (previous, next) {
        _getTaskList(ref);
      },
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appBar,
      body: SafeArea(
        child: SizedBox(
          height: kScreenHeight,
          width: kScreenWidth,
          child: Padding(
            padding: kHorizontalScrPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: kScreenWidth,
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 16.0),
                        child: FaIcon(FontAwesomeIcons.filter,
                            size: 16, color: AppColors.white.withAlpha(200)),
                      ),
                      FilterItem(
                          label: 'Deleted',
                          isSelected:
                              filterController[TaskFilter.deleted] ?? false,
                          icon: FontAwesomeIcons.trash,
                          iconSize: 13,
                          onTap: () => _onDeletedButtonTap(ref)),
                      FilterItem(
                          label: 'Skipped',
                          isSelected:
                              filterController[TaskFilter.skipped] ?? false,
                          icon: Icons.skip_next,
                          iconSize: 16,
                          onTap: () => _onSkippedButtonTap(ref)),
                    ],
                  ),
                ),
                // show Task history if Available
                if(taskHistory.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                  itemCount: taskHistory.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        bottom: index + 1 == taskHistory.length ? 100.0 : 0),
                    child:
                        TaskHistoryItemCard(task: taskHistory[index]),
                  ),
                )),

                //show No Content placeholder is task history not available
                if(taskHistory.isEmpty)
                  const Expanded(child: EmptyContentPlaceHolder(label: 'No History available',))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
