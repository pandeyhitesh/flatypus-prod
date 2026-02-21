import 'package:flatypus/constants/demo_data.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/schedule_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectScheduleDropdown extends ConsumerWidget {
  const SelectScheduleDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleController = ref.watch(scheduleSectionControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: kScreenWidth,
        child: DropdownButton<TaskSchedule>(
          value: scheduleController,
          // hint: Text(
          //   '-- Select Space --',
          //   style: TextStyle(
          //     color: AppColors.white.withOpacity(.5),
          //   ),
          // ),
          items:
              kTaskSchedule.keys
                  .map<DropdownMenuItem<TaskSchedule>>(
                    (sch) => DropdownMenuItem<TaskSchedule>(
                      value: sch as TaskSchedule,
                      child: Text(kTaskSchedule[sch]!),
                    ),
                  )
                  .toList(),
          onChanged:
              (newValue) =>
                  ref.read(scheduleSectionControllerProvider.notifier).state =
                      newValue!,
          padding: EdgeInsets.zero,
          style: TextStyle(
            color: AppColors.white.withOpacity(.8),
            fontSize: 14,
            letterSpacing: .5,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
          dropdownColor: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
          iconEnabledColor: AppColors.white.withOpacity(.5),
        ),
      ),
    );
  }
}
