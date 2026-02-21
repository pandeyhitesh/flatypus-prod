import 'package:flatypus/constants/demo_data.dart';
import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/custom_week_days_selection.dart';
import 'package:flatypus/features/common/widgets/text_with_icon_header.dart';
import 'package:flatypus/features/task/presentation/widgets/add_task/custom_week_selection.dart';
import 'package:flutter/material.dart';

class CustomTaskSchedule extends StatelessWidget {
  const CustomTaskSchedule({super.key, this.taskSchedule, this.weekDays});
  final TaskSchedule? taskSchedule;
  final List<Day>? weekDays;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kScreenWidth - 2 * kScreenPadding,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: textWithIconHeader(
              value: kTaskSchedule[taskSchedule]!,
              icon: Icons.schedule_outlined,
            ),
          ),
          if (taskSchedule == TaskSchedule.customWeek)
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: CustomWeekSelection(
                selectedWeek: weekDays,
                isDisplayOnly: true,
              ),
            ),
        ],
      ),
    );
  }
}
