import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/custom_week_days_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomWeekSelection extends ConsumerWidget {
  const CustomWeekSelection({
    super.key,
    this.selectedWeek,
    this.isDisplayOnly = false,
  });
  final List<Day>? selectedWeek;
  final bool isDisplayOnly;

  List<Day>? getSelectedWeek(List<Day> weekFromController) {
    if (isDisplayOnly) return selectedWeek;
    return weekFromController;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekController = getSelectedWeek(
      ref.watch(customWeekSelectionProvider),
    );
    final double horPadding = isDisplayOnly ? 10 : 10.0;
    final double verPadding = isDisplayOnly ? 5 : 5.0;
    if (weekController == null) return const SizedBox();
    return SizedBox(
      width: kScreenWidth,
      // height: 20,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horPadding,
          vertical: verPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
              weekController
                  .map((d) => _dayElements(ref: ref, day: d))
                  .toList(),
        ),
      ),
    );
  }

  Widget _dayElements({required WidgetRef ref, required Day day}) {
    return SizedBox(
      height: 40,
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _onDayElementTap(ref, day),
          child: Container(
            // height: 20,
            // width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  day.isSelected
                      ? AppColors.white.withOpacity(.7)
                      : AppColors.primaryColor,
            ),
            child: Center(
              child: Text(
                day.d,
                style: TextStyle(
                  color:
                      day.isSelected ? AppColors.primaryColor : AppColors.white,
                  fontSize: isDisplayOnly ? 10 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDayElementTap(WidgetRef ref, Day day) {
    ref
        .read(customWeekSelectionProvider.notifier)
        .updateDaySelection(day.dayNo);
  }
}
