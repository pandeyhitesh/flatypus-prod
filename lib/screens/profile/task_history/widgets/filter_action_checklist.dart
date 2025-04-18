import 'package:flatypus/common/methods.dart';
import 'package:flatypus/state/controllers/task_history_filter_controller.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TaskFilter { completed, skipped, deleted }

// final Map<TaskFilter, bool> _selectedFilters = {
//   TaskFilter.completed: true,
//   TaskFilter.skipped: true,
//   TaskFilter.deleted: true,
// };

List<Widget> filterActionCheckList() {
  return [
    Consumer(builder: (context, ref, _) {
      final selectedFilters = ref.watch(taskHistoryFilterProvider);
      print('selectedFilters = $selectedFilters');
      return PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          color: AppColors.primaryColor,
          elevation: 10,
          itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false, // Make header unselectable
                  child: Text(
                    "Filtered Items",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                ...TaskFilter.values.map((filter) => PopupMenuItem(
                      child: CheckboxListTile(
                        selected: selectedFilters[filter] ?? false,
                        visualDensity: VisualDensity.compact,
                        title: Text(filter.name.capitalize()),
                        value: selectedFilters[filter],
                        onChanged: (bool? value) {
                          // Map<TaskFilter, bool> taskFilter = selectedFilters;
                          // taskFilter[filter] = value ?? false;
                          ref
                              .read(taskHistoryFilterProvider.notifier)
                              .updateFilter(filter, value ?? false);
                          pop(); // Close dropdown after selection
                        },
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: AppColors.yellowAccent2,
                        dense: false,
                      ),
                    )),
              ]);
    })
  ];
}
