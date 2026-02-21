// import 'package:flatypus/screens/profile/task_history/widgets/filter_action_checklist.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TaskHistoryFilterNotifier extends StateNotifier<Map<TaskFilter, bool>> {
//   TaskHistoryFilterNotifier() : super(_defaultFilters);
//   static const Map<TaskFilter, bool> _defaultFilters = {
//     TaskFilter.skipped: false,
//     TaskFilter.deleted: false,
//   };
//   updateFilter(TaskFilter filter, bool value) {
//     state = {...state, filter: value};
//   }
// }

// final taskHistoryFilterProvider =
//     StateNotifierProvider<TaskHistoryFilterNotifier, Map<TaskFilter, bool>>(
//         (ref) => TaskHistoryFilterNotifier());
