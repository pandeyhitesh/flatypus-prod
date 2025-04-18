import 'package:flatypus/common/methods.dart';
import 'package:flatypus/common/methods/date_selection.dart';
import 'package:flatypus/state/controllers/task_date_selection_controller.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDateSelection extends ConsumerWidget {
  const TaskDateSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(taskDateSelectionControllerProvider);
    return SizedBox(
      width: kScreenWidth / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Dt: ${selectedDate == null ? 'N/A' : fullDateFormat.format(selectedDate)}',
              style:  TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.white.withOpacity(.8),
                letterSpacing: .5,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () => _onDateSelectionTap(context, ref),
              icon: const Icon(
                Icons.calendar_month,
                size: 24,
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_onDateSelectionTap(BuildContext context, WidgetRef ref) {
  selectDateFromCalendar(
    context: context,
    ref: ref,
    dateController: taskDateSelectionControllerProvider,
  );
}
